{ pkgs, lib, options, inputs, system, ... }: {
  # Use the GRUB 2 boot loader.
  boot = {
    initrd = {
      availableKernelModules =
        [ "uhci_hcd" "ehci_pci" "ahci" "aacraid" "usbhid" "sd_mod" "sr_mod" ];
      kernelModules = [ "kvm-intel" ];
    };
    extraModulePackages = [ ];
    loader.grub.enable = true;
    loader.grub.version = 2;
    loader.grub.devices = [ "/dev/sda" "/dev/sdb" ];
    kernelParams = [ "mitigations=off" "aacraid.expose_physicals=1" ];
    kernel.sysctl = {
      "kernel.sysrq" = 1;
      "dev.raid.speed_limit_min" = 10000;
      "dev.raid.speed_limit_max" = 90000;
      "vm.overcommit_memory" = "1";
    };

    # remove the fsck that runs at startup. It will always fail to run, stopping
    # your boot until you press *.
    initrd.checkJournalingFS = false;
  };

  fileSystems = {
    "/".device = "/dev/disk/by-label/nixos";
    "/var/lib/jenkins".device = "/dev/disk/by-label/jenkins";
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

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

  services = {
    openssh = { enable = true; };

    dbus.enable = true;
    ci = {
      enable = true;
      gitlabGroups = [
        { name = "hms"; }
        { name = "apps"; }
        { name = "backup"; }
        { name = "base"; }
        { name = "billing2"; }
        { name = "_ci"; }
        { name = "db"; }
        { name = "deploy"; }
        { name = "domains"; }
        { name = "folders"; }
        { name = "kvm-templates"; }
        { name = "legacy"; }
        { name = "mail"; }
        { name = "monitoring"; }
        { name = "net"; }
        { name = "nixos"; }
        { name = "office"; }
        { name = "pipelines"; }
        { name = "pr"; }
        { name = "security"; }
        { name = "tests"; }
        { name = "utils"; }
        { name = "webservices"; }
      ];
      jcasc.jenkins.nodes = options.services.ci.jcasc.default // {
        jcasc.jenkins.nodes = (options.services.ci.jcasc.default.jenkins.nodes
          ++ (map (host: {
            permanent = {
              inherit (host) name labelString;
              launcher = {
                ssh = {
                  credentialsId = "jenkins-ssh-deploy";
                  host = host.name + ".intr";
                  port = 22;
                  sshHostKeyVerificationStrategy =
                    "knownHostsFileKeyVerificationStrategy";
                };
              };
              nodeDescription = host.name;
              numExecutors = 1;
              remoteFS = "/home/jenkins";
              retentionStrategy = {
                demand = {
                  idleDelay = 1;
                  inDemandDelay = 0;
                };
              };
            };
          })) [
            {
              labelString = "restic backup";
              name = "bareos";
            }
            {
              labelString = "pxe elk";
              name = "chef-server";
            }
            {
              labelString = "dhost-production";
              name = "dh1";
            }
            {
              labelString = "js";
              name = "ci";
            }
            {
              labelString = "dhost-production";
              name = "dh2";
            }
            {
              labelString = "dhost-production";
              name = "dh3";
            }
            {
              labelString = "dhost-development";
              name = "dh4";
            }
            {
              labelString = "dhost-development";
              name = "dh5";
            }
            {
              labelString = "elk";
              name = "fluentd";
            }
            {
              labelString = "production";
              name = "hms01";
            }
            {
              labelString = "production";
              name = "hms02";
            }
            {
              labelString = "production";
              name = "hms03";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm1";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm10";
            }
            {
              labelString = "kvm kvmbionic kvm-template-builder";
              name = "kvm11";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm12";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm13";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm14";
            }
            {
              labelString = "kvm kvm-template-builder";
              name = "kvm15";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm16";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm17";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm19";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm2";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm20";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm21";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm22";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm23";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm24";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm25";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm26";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm27";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm28";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm29";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm30";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm31";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm32";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm33";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm34";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm35";
            }
            {
              labelString = "";
              name = "kvm36";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm37";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm5";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm6";
            }
            {
              labelString = "kvm kvmbionic";
              name = "kvm9";
            }
            {
              labelString = "kvm-template-builder";
              name = "mx1-mr";
            }
            {
              labelString = "kvm-template-builder prometheus-server";
              name = "mx2-mr";
            }
            {
              labelString = "mail-production webmail-mr smtp-out";
              name = "webmail1-mr";
            }
            {
              labelString = "mail-production webmail-mr smtp-out";
              name = "webmail2-mr";
            }
            {
              labelString = "nginx-mr";
              name = "nginx1";
            }
            {
              labelString = "nginx-mr";
              name = "nginx2";
            }
            {
              labelString = "dns-production";
              name = "ns1-dh";
            }
            {
              labelString = "dns-production";
              name = "ns1-mr";
            }
            {
              labelString = "dns-production";
              name = "ns2-dh";
            }
            {
              labelString = "dns-production";
              name = "ns2-mr";
            }
            {
              labelString = "pop";
              name = "pop1";
            }
            {
              labelString = "pop pop-nix";
              name = "pop2";
            }
            {
              labelString = "pop elk";
              name = "pop5";
            }
            {
              labelString = "web";
              name = "web15";
            }
            {
              labelString = "web";
              name = "web16";
            }
            {
              labelString = "web";
              name = "web17";
            }
            {
              labelString = "web";
              name = "web18";
            }
            {
              labelString = "web";
              name = "web19";
            }
            {
              labelString = "web";
              name = "web20";
            }
            {
              labelString = "web";
              name = "web21";
            }
            {
              labelString = "web";
              name = "web22";
            }
            {
              labelString = "web";
              name = "web23";
            }
            {
              labelString = "web";
              name = "web25";
            }
            {
              labelString = "web";
              name = "web26";
            }
            {
              labelString = "web";
              name = "web27";
            }
            {
              labelString = "web";
              name = "web28";
            }
            {
              labelString = "web";
              name = "web29";
            }
            {
              labelString = "web";
              name = "web30";
            }
            {
              labelString = "web";
              name = "web31";
            }
            {
              labelString = "web";
              name = "web32";
            }
            {
              labelString = "web";
              name = "web33";
            }
            {
              labelString = "web";
              name = "web34";
            }
            {
              labelString = "web";
              name = "web35";
            }
            {
              labelString = "web";
              name = "web36";
            }
            {
              labelString = "web";
              name = "web37";
            }
          ]);
      };
    };

    jenkins = {
      packages = with pkgs; [
        bats
        bind
        influxdb-subscription-cleaner
        nix
        nodejs
        packer
      ];
    };
  };

  programs.adb.enable = true;

  system.stateVersion = "19.09";

  systemd.services = {
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
    android_sdk.accept_license = true;
  };

  nix = {
    maxJobs = lib.mkDefault 64;
    trustedUsers = [ "root" "eng" ];
    gc = {
      automatic = false;
      options = "--delete-older-than 14d";
    };
    requireSignedBinaryCaches = true;
    extraOptions = ''
      tarball-ttl = 30
      narinfo-cache-negative-ttl = 3
      max-silent-time = ${toString (60 * 10)}
    '';
  };

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
    extraHosts = ''
      127.0.0.1 jenkins.intr
    '';
  };

  time.timeZone = "Europe/Moscow";

  environment.systemPackages = with pkgs; [
    bind
    file
    findutils
    gcc9
    gron
    htop
    iotop
    iputils
    jdk
    jq
    killall
    kvm
    netcat
    nettools
    nix-generate-from-cpan
    nix-prefetch-docker
    nix-prefetch-git
    nodejs
    python27Full
    rsync
    screen
    sg3_utils
    skopeo
    smartmontools
    sysstat
    tmux
    tree
    unzip
    wget
    yq
  ];

  environment.interactiveShellInit = ''
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
    export XDG_RUNTIME_DIR=/run/user/$UID
  '';

  services.nix-serve = {
    enable = true;
    secretKeyFile = "${
        inputs.ssl-certificates.packages.${system}.certificates
      }/nix-serve/cache-priv-key.pem";
  };

  disabledModules = [ "services/monitoring/zabbix-agent.nix" ];
  imports = with inputs.nix-flake-common.nixosModules; [
    zabbix-agent
    mjzabbix
    mj-smartd
    eng
    sup
    security
  ];
}
