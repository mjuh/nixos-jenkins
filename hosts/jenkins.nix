{ pkgs, lib, inputs, system, ... }: {
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
    openssh = {
      enable = true;
    };

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
    git
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
