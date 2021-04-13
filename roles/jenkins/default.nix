{ config, pkgs, inputs, system, ... }: {
  disabledModules = [ "services/monitoring/zabbix-agent.nix"];
  imports = [ # Include the results of the hardware scan.
    # ./zram.nix # XXX: Fix before uncomment
    inputs.nix-flake-common.nixosModules.zabbix-agent
    ./services/admin.nix
    # TODO: Add androidemu in ./roles/jenkins/android.nix file.
    ./services/jenkins.nix
    ./hardware-configuration.nix
    ./packages.nix
    inputs.nix-flake-common.nixosModules.eng
    inputs.nix-flake-common.nixosModules.sup
    # inputs.nix-flake-common.nixosModules.pkgs.override
    inputs.nix-flake-common.nixosModules.security
  ];

  environment.systemPackages =
    (with pkgs; [ sqlite woof ])
    ++ (with inputs.majordomo.packages.${system}; [ arcconf influxdb-subscription-cleaner ])
    ++ (with inputs.nixpkgs-unstable.legacyPackages.${system}; [ packer ]);

  nixpkgs.config.packageOverrides = pkgs: with pkgs; rec {
    addsshnode = callPackage ./ci/jenkins/add-ssh-node { };
    genjenkplugins = callPackage ./ci/jenkins/gen-jenk-plugins { };
    jdk11 = pkgs.jdk8.override {
      cacert = pkgs.runCommand "mycacert" { } ''
        mkdir -p $out/etc/ssl/certs
        cat ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
          ${inputs.ssl-certificates.packages.${system}.certificates}/Majordomo_LLC_Root_CA.crt \
          > $out/etc/ssl/certs/ca-bundle.crt
      '';
    };
    jdk = jdk11;
    inherit (pkgs) cached-nix-shell;
  };

  boot.kernelPackages = pkgs.linuxPackages_4_4;
  # kernelPatches = [{
  #   name = "fix-adaptec-6405e";
  #   patch = ./adaptec.patch;
  # }];

  services = {
    udev.packages = [ pkgs.android-udev-rules ];
    
    # XXX:
    # services.gitlab.serviceConfig.TimeoutStartSec = "10min";
    # gitlab-runner.path = with pkgs; [ shadow.su ];

    # zabbixAgent = {
    #   enable = true;
    #   package =
    #     pkgs.zabbix30.agent.overrideAttrs (old: { version = "3.4.11"; });
    #   listen.ip = with pkgs.lib;
    #     (head config.networking.interfaces.enp1s0f0.ipv4.addresses).address;
    #   server = "zabbix.intr";
    #   extraConfig = ''
    #     Hostname=${config.networking.hostName}
    #     Timeout=20
    #     Include=${inputs.zabbix-agentd-conf.packages.${system}.zabbix-agentd-conf}/etc/zabbix_agentd.conf.d
    #   '';
    # };

   nginx = {
      preStart = " set -x ; mkdir -p /run/nginx /var/log/nginx/ ; chown -R nginx:nginx /run/nginx /var/log/nginx/ ; ls -la /run/nginx";
      enable = true;
      # recommendedProxySettings = true;
      virtualHosts = {

        # XXX:
        # "gitlab.intr" = {
        #   serverAliases = [ "gitlab2.intr" "gitlab3.intr" ];
        #   locations."/".proxyPass =
        #     "http://unix:/run/gitlab/gitlab-workhorse.socket";
        #   locations."/".extraConfig = ''
        #     proxy_set_header Host $host;
        #     proxy_read_timeout 300;
        #     proxy_connect_timeout 300;
        #     proxy_redirect     off;

        #     proxy_set_header   X-Forwarded-Proto http;
        #     proxy_set_header   X-Real-IP         $remote_addr;
        #     proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for;
        #   '';
        # };

        "cache.nixos.intr" = with inputs.ssl-certificates.packages.${system}; {
          addSSL = true;
          #        forceSSL = false;
          sslCertificate =
            "${certificates}/ssl/cache.nixos.intr.pem";
          sslCertificateKey =
            "${certificates}/ssl/cache.nixos.intr.key";
          locations."/".extraConfig = ''
            proxy_pass http://localhost:${
              toString config.services.nix-serve.port
            };
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          '';
        };
      };
    };
   };
}
