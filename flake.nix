{
  description = "Majordomo NixOS Jenkins configuration";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    deploy-rs.url = "git+ssh://git@gitlab.intr/_ci/deploy-rs?ref=dry_activate";
    utils.url = "github:numtide/flake-utils";

    majordomo.url = "git+https://gitlab.intr/_ci/nixpkgs";
    ssl-certificates.url = "git+ssh://git@gitlab.intr/office/ssl-certificates";
    zabbix-agentd-conf.url = "git+ssh://git@gitlab.intr/chef/service";
    nix-flake-common.url = "git+ssh://git@gitlab.intr/_ci/nixops";
    nixpkgs-vulnix = {
      url = "github:nixos/nixpkgs/329102c47bd1c68f0acdf4feec64232202948c7a";
      flake = false;
    };
  };

  outputs = { self
            , nixpkgs
            , nixpkgs-unstable
            , deploy-rs
            , majordomo
            , ssl-certificates
            , nix-flake-common
            , zabbix-agentd-conf
            , ... } @ inputs:
              let
                system = "x86_64-linux";
                pkgs = import nixpkgs { inherit system; };
                pkgs-unstable = import nixpkgs-unstable { inherit system; };
                inherit (pkgs) lib;
                directoryToNixosConfigurations = directory: with pkgs.lib;
                  foldr
                    (host: hosts:
                      hosts //
                      {
                        ${(removeSuffix ".nix" (builtins.baseNameOf host))} =
                          nixpkgs.lib.nixosSystem {
                            inherit system;
                            modules = [ host ];
                            specialArgs = { inherit inputs system; };
                          };
                      })
                    { }
                    (pkgs-unstable.lib.filesystem.listFilesRecursive directory);
              in {
                nixosConfigurations = directoryToNixosConfigurations ./hosts;

                deploy.nodes = with lib;
                  listToAttrs
                    (mapAttrsFlatten
                      (name: nixos:
                        nameValuePair
                          name
                          {
                            hostname = name;
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

                                sshUser = "root";

                                user = "root";
                              };
                            };
                          })
                      (directoryToNixosConfigurations ./hosts));

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
