{
    imports = [ ../roles/jenkins ];
    users.motd = ''
      Сервисы Systemd:
        jenkins-job-builder.service  добавляет и останавливает Jenkins Jobs
        jenkins-credentials.service  настраивает credentials
        jenkins.service              копирует плагины, запускает Jenkins и JCasC
    '';

    # Use the GRUB 2 boot loader.
    boot = {
      loader.grub.enable = true;
      loader.grub.version = 2;
      loader.grub.devices = ["/dev/sda" "/dev/sdb"];
      kernelParams = [ "mitigations=off" "aacraid.expose_physicals=1" ];
      kernel.sysctl = {
        "kernel.sysrq" = 1;
        "dev.raid.speed_limit_min" = 10000;
        "dev.raid.speed_limit_max" = 90000;
        "vm.overcommit_memory" = "1";
        # "vm.swappiness" = 1;
      };

      # remove the fsck that runs at startup. It will always fail to run, stopping
      # your boot until you press *.
      initrd.checkJournalingFS = false;
    };

    virtualisation = {
      docker.enable = true;
      docker.enableOnBoot = false;
    };

    # XXX:
    # jenkins ALL=NOPASSWD:/run/current-system/sw/bin/nixos-rebuild build*,/run/current-system/sw/bin/nix-channel*
    #
    # XXX:
    # Don't use “ALL=(ALL:ALL) NOPASSWD:ALL” for zabbix-agent
    security.sudo.extraConfig = ''
      jenkins ALL=(ALL:ALL) NOPASSWD:ALL
      zabbix-agent ALL=(ALL:ALL) NOPASSWD:ALL
    '';

    # Services to enable:

    # Enable the OpenSSH daemon.
    services = {
      dbus.enable = true;
      # timesyncd.enable = true; # Replace ntpd by timesyncd

      cron = {
        enable = true;
        systemCronJobs = [
          # m h dom mon dow user  command
          "01 */11 * * * root nix-store --delete /nix/store/*preload-image* ; nix-store --delete /nix/store/*granular-docker*"
          "01 */10 * * 01 root rm -rf /tmp/nix-* /tmp/vm-s*"
        ];
      };

      # XXX: Check systemctl status
      # gitlab-runner = {
      #   enable = true;
      #   configFile = "/etc/gitlab-runner/config.toml";
      #   package = with pkgs;
      #     (import (fetchgit.override { cacert = mjcacert; } {
      #       url = "https://gitlab.intr/nixos/nixpkgs.git";
      #       rev = "fba7d8e27fe8cd7edd7dd9ffee43ffbd14df3e51";
      #       sha256 = "0n42rr4b00cx63wnrhcg5lj9bqdm3xvw33s6x9xqxw942r9hz3fy";
      #     }) { }).gitlab-runner.overrideAttrs
      #     (old: { patches = old.patches ++ [ ../roles/jenkins/fix-kill.patch ]; });
      # };

    };

    programs.adb.enable = true;

    system.stateVersion = "19.09";
    # system.autoUpgrade.enable = true;
    # system.autoUpgrade.channel = "https://nixos.org/channels/nixos-19.09";

    systemd.services = {
      # "serial-getty@ttyS0".serviceConfig.Restart = "always";
      # "serial-getty@ttyS0".serviceConfig.RestartSec = 3;
      # "serial-getty@ttyS0".wantedBy = ["multi-user.target"];
      # "serial-getty@ttyS0".enable = true;

      "serial-getty@ttyS0" = {
        enable = true;
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Restart = "always";
          RestartSec = 3;
        };
      };

      "enable-ksm" = {
        enable = true;
        description = "Enable Kernel Same-Page Merging";
        wantedBy = [ "multi-user.target" ];
        after = [ "systemd-udev-settle.service" ];
        script = ''
          if [ -e /sys/kernel/mm/ksm ]; then
            echo 1 > /sys/kernel/mm/ksm/run
          fi
        '';
      };
    };

    nixpkgs.config = {
      oraclejdk.accept_license = true;
      #    allowBroken = false;
      android_sdk.accept_license = true;
    };

    nix = {
      gc = {
        automatic = false;
        options = "--delete-older-than 14d";
      };
      requireSignedBinaryCaches = false;
      extraOptions = ''
        tarball-ttl = 30
        narinfo-cache-negative-ttl = 3
        max-silent-time = ${toString (60 * 10)}
      '';
      # binary-caches = https://cache.nixos.org/ http://kvm15.intr:5556/
      # builders-use-substitutes = true
      # distributedBuilds = true;
      # buildMachines = [
      #   {
      #     hostName = "kvm15";
      #     system = "${system}";
      #     # if the builder supports building for multiple architectures,
      #     # replace the previous line by, e.g.,
      #     # systems = ["${system}" "aarch64-linux"];
      #     maxJobs = 8;
      #     speedFactor = 2;
      #     supportedFeatures = [ ];
      #     mandatoryFeatures = [ ];
      #   }
      # ];
    };

    environment.interactiveShellInit = builtins.readFile ../roles/jenkins/.bashrc;

    networking = {
      dhcpcd.enable = false;
      hostName = "jenkins";
      firewall.enable = false;
      interfaces.enp1s0f0.ipv4.addresses = [{
        address = "172.16.103.238";
        prefixLength = 24;
      }];
      defaultGateway = "172.16.103.1";
      nameservers = [ "172.16.103.2" "172.16.102.2" "8.8.8.8" ];
      search = [ "intr" "majordomo.ru" ];
    };

    time.timeZone = "Europe/Moscow";

    # XXX:
    # services.gitlab = {
    #   enable = false;
    #   databasePasswordFile = pkgs.writeText "dbPassword" "xxxxxxxx";
    #   initialRootPasswordFile =
    #     pkgs.writeText "rootPassword" initialRootPassword;
    #   secrets = {
    #     secretFile = pkgs.writeText "secret" "xxxxxxxx";
    #     otpFile = pkgs.writeText "otpsecret" "xxxxxxxx";
    #     dbFile = pkgs.writeText "dbsecret" "xxxxxxxx";
    #     jwsFile = pkgs.runCommand "oidcKeyBase" { }
    #       "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
    #   };
    #   host = "gitlab2.intr";
    #   extraGitlabRb = ''
    #     external_url = "http://gitlab2.intr";
    #   '';
    #   https = false;
    # };

}
