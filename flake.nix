{
  description = "Majordomo NixOS Jenkins configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-deprecated = {
      url = "github:nixos/nixpkgs/ef7c2d3cea3714d24669e16c290dcc8ffb703c3b";
      flake = false;
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    deploy-rs.url = "github:serokell/deploy-rs";
    utils.url = "github:numtide/flake-utils";

    majordomo.url = "git+https://gitlab.intr/_ci/nixpkgs";
    ssl-certificates.url = "git+ssh://git@gitlab.intr/office/ssl-certificates";
    zabbix-agentd-conf.url = "git+ssh://git@gitlab.intr/chef/service";
    flake-utils.url = "github:numtide/flake-utils";
    nix-flake-common.url = "git+ssh://git@gitlab.intr/_ci/nixops";
    nixpkgs-vulnix = {
      url = "github:nixos/nixpkgs/329102c47bd1c68f0acdf4feec64232202948c7a";
      flake = false;
    };
    nixpkgs-20-09.url = "nixpkgs/nixos-20.09";
    vault-secrets.url = "git+https://github.com/serokell/vault-secrets";
    home-manager.url = "github:nix-community/home-manager";
    guix.url = "github:foo-dogsquared/nix-overlay-guix";
    nixos-ns.url = "git+ssh://git@gitlab.intr/nixos/ns";
  };

  outputs = { self
            , nixpkgs
            , nixpkgs-unstable
            , nixpkgs-vulnix
            , nixpkgs-deprecated
            , flake-utils
            , deploy-rs
            , majordomo
            , ssl-certificates
            , nix-flake-common
            , zabbix-agentd-conf
            , vault-secrets
            , home-manager
            , guix
            , nixos-ns
            , ... } @ inputs:
              let
                system = "x86_64-linux";
                pkgs = import nixpkgs { inherit system; };
                pkgs-unstable = import nixpkgs-unstable { inherit system; };
                pkgs-deprecated = import nixpkgs-deprecated { inherit system; };
                inherit (pkgs) lib;
                hm = import home-manager { inherit system; };
              in rec {
                packages.${system} = rec {
                  jdk11 = jdk;
                  jdk = pkgs.jdk8.override {
                    cacert = pkgs.runCommand "mycacert" {} ''
                      mkdir -p $out/etc/ssl/certs
                      cat ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
                        ${ssl-certificates.packages.${system}.certificates}/Majordomo_LLC_Root_CA.crt > $out/etc/ssl/certs/ca-bundle.crt
                    '';
                  };
                  jenkins-update-plugins = with pkgs;
                    let
                      plugins = with builtins; concatStringsSep " "
                        (map
                          (plugin: "-p ${plugin}")
                          [
                            "ansicolor"
                            "blueocean"
                            "docker-workflow"
                            "git"
                            "gitlab-branch-source"
                            "gradle"
                            "hashicorp-vault-plugin"
                            "junit"
                            "lockable-resources"
                            "pipeline-utility-steps"
                            "nexus-jenkins-plugin"
                            "slack"
                            "ssh-slaves"
                            "ws-cleanup"
                            "workflow-aggregator"
                            "workflow-multibranch"
                          ]);
                    in writeScriptBin "jenkins-update-plugins"
                      ''
                        #!${runtimeShell}
                        exec -a "$0" nix run git+https://github.com/Fuuzetsu/jenkinsPlugins2nix -- ${plugins} "$@"
                      '';
                };

                overlay = final: prev: packages.${system} // {
                  inherit (majordomo.packages.${system})
                    arcconf influxdb-subscription-cleaner;

                  inherit (import nixpkgs-vulnix { inherit system; })
                    vulnix;

                  inherit (pkgs-unstable)
                    jenkins;

                  inherit (pkgs-deprecated)
                    openjdk14;

                  inherit (guix.packages.${system}) guix_binary_1_3_0;

                  inherit (deploy-rs.packages.${system}) deploy-rs;
                };

                lib = {
                  knownHosts = import ./known_hosts.nix {
                    inherit (pkgs) writeText;
                    nixosConfigurations =
                      pkgs.lib.foldr
                        (flake: nixosConfigurations:
                          nixosConfigurations // flake.nixosConfigurations)
                        {}
                        [
                          nixos-ns
                        ];
                  };
                };

                apps.${system}.jenkins-update-plugins = flake-utils.lib.mkApp {
                  drv = packages.${system}.jenkins-update-plugins;
                };
                defaultApp.${system} = apps.${system}.jenkins-update-plugins;
                
                nixosModules = with nixpkgs.legacyPackages.${system}.lib;
                  foldr
                    (file: files:
                      files //
                      {
                        ${(removeSuffix ".nix" (builtins.baseNameOf file))} = (import file);
                      })
                    { }
                    (filesystem.listFilesRecursive ./nixos/modules);

                nixosConfigurations =
                  with pkgs.lib;
                  foldr
                    (host: hosts:
                      hosts //
                      (let
                        name = removeSuffix ".nix" (builtins.baseNameOf host);
                        hostName = removeSuffix ".nix" (builtins.baseNameOf host);
                      in {
                        ${name} =
                          nixpkgs.lib.nixosSystem {
                            pkgs = import nixpkgs {
                              inherit system;
                              overlays = [ overlay ];
                            };
                            inherit system;
                            modules = [
                              self.nixosModules."hardware-${hostName}"
                              host
                              vault-secrets.nixosModules.vault-secrets
                              guix.nixosModules.guix-binary
                            ] ++ (attrValues self.nixosModules)
                              ++ (if name == "vm" then [(pkgs.path + /nixos/modules/virtualisation/qemu-vm.nix)] else []);
                            specialArgs = {
                              inherit inputs system;
                              flake = self;
                            };
                          };
                      }))
                    { }
                    (pkgs-unstable.lib.filesystem.listFilesRecursive ./hosts);

                deploy.nodes = with pkgs.lib;
                  listToAttrs
                    (mapAttrsFlatten
                      (name: nixos:
                        nameValuePair
                          name
                          {
                            hostname = name + ".intr";
                            profiles = {
                              system = {
                                # If the previous profile should be re-activated if activation fails.
                                # This defaults to `true`
                                autoRollback = false;

                                # https://github.com/serokell/deploy-rs#magic-rollback
                                #
                                # There is a built-in feature to prevent you making
                                # changes that might render your machine unconnectable
                                # or unusuable, which works by connecting to the machine
                                # after profile activation to confirm the machine is
                                # still available, and instructing the target node to
                                # automatically roll back if it is not confirmed. If you
                                # do not disable magicRollback in your configuration
                                # (see later sections) or with the CLI flag, you will be
                                # unable to make changes to the system which will affect
                                # you connecting to it (changing SSH port, changing your
                                # IP, etc).
                                magicRollback = false;
                                confirmTimeout = 300;

                                path = deploy-rs.lib.${system}.activate.nixos
                                  self.nixosConfigurations."${name}";

                                sshUser = "jenkins";

                                user = "root";
                              };
                              jenkins = rec {
                                user = "jenkins";
                                sshUser = user;
                                profilePath = "/nix/var/nix/profiles/per-user/${user}/home-manager";
                                autoRollback = false;
                                magicRollback = false;
                                path = deploy-rs.lib.${system}.activate.home-manager (home-manager.lib.homeManagerConfiguration {
                                  inherit pkgs system;
                                  extraSpecialArgs = {
                                    inherit pkgs inputs;
                                    inherit (self) nixosConfigurations;
                                  };
                                  homeDirectory = "/home/${user}";
                                  username = user;
                                  configuration = ./home-manager/configuration.nix;
                                });
                              };
                            };
                          })
                      (filterAttrs (name: nixos: name != "vm") nixosConfigurations));

                checks =
                  builtins.mapAttrs
                    (system: deployLib: deployLib.deployChecks self.deploy)
                    deploy-rs.lib;

                devShell.x86_64-linux = with pkgs-unstable; mkShell {
                  buildInputs = [
                    nixUnstable
                    nixos-rebuild
                    deploy-rs.outputs.packages.${system}.deploy-rs
                  ];
                };
              };
}
