{ config, pkgs, lib, options, inputs, system, ... }:

let
  inherit (lib)
    fold;
in
{
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.mirroredBoots = [{
    efiSysMountPoint = "/boot1/efi";
    path = "/boot1";
    devices = [ "nodev" ];
  }];

  virtualisation = {
    docker.enable = true;
    docker.enableOnBoot = false;
  };

  fileSystems."/var/log/nginx" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=3G" "mode=755" ]; # mode=755 so only root can write to those files
  };

  # XXX:
  # jenkins ALL=NOPASSWD:/run/current-system/sw/bin/nixos-rebuild build*,/run/current-system/sw/bin/nix-channel*
  #
  # XXX:
  # Don't use “ALL=(ALL:ALL) NOPASSWD:ALL” for zabbix-agent
  security.sudo.extraConfig = ''
    jenkins ALL=(ALL:ALL) NOPASSWD:ALL
  '';

  services = {
    openssh = { enable = true; };

    dbus.enable = true;
    ci = {
      enable = true;
      gitlabGroups = [];
    };

    jenkins = {
      packages = with pkgs; [
        bind
        deploy-rs
        influxdb-subscription-cleaner
        nixFlakes
        nodejs
        packer
      ];
    };
  };

  programs.adb.enable = true;

  system.stateVersion = "21.11";

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

    jenkins = {
      preStart = lib.mkBefore ''
        echo "This is a workaround, Jenkins will not run by this service."
        exit 0
      '';
      script = lib.mkBefore ''
        echo "This is a workaround, Jenkins will not run by this service."
        exec ${pkgs.coreutils}/bin/sleep infinity
      '';
      postStart = lib.mkBefore ''
        echo "This is a workaround, Jenkins will not run by this service."
        exit 0
      '';
    };
  };

  nixpkgs.config = {
    oraclejdk.accept_license = true;
    android_sdk.accept_license = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    maxJobs = lib.mkDefault 64;
    trustedUsers = [ "root" "eng" ];
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    requireSignedBinaryCaches = true;
    extraOptions = ''
      experimental-features = nix-command flakes
      tarball-ttl = 30
      narinfo-cache-negative-ttl = 3
      max-silent-time = ${toString (60 * 10)}
    '';
  };

  networking = {
    resolvconf = {
      useLocalResolver = false;
    };
    dhcpcd.enable = false;
    hostName = "deprecated-jenkins";
    firewall.enable = false;
    bonds.bond0 = {
      interfaces = [ "enp1s0f0" "enp1s0f1" ];
      driverOptions = {
        mode = "802.3ad";
        lacp_rate = "fast";
      };
    };
    vlans = {
      vlan252 = {
        id = 109;
        interface = "bond0";
      };
      vlan253 = {
        id = 253;
        interface = "bond0";
      };
    };
    interfaces = {
      vlan252.ipv4 = {
        addresses = [{
          address = "192.168.103.3";
          prefixLength = 24;
        }];
        routes = [{
          address = "192.168.103.0";
          prefixLength = 24;
          via = "192.168.103.1";
        }];
      };
      vlan253.ipv4 = {
        addresses = [{
          address = "172.16.103.238";
          prefixLength = 24;
        }];
        routes = [{
          address = "172.16.0.0";
          prefixLength = 16;
          via = "172.16.103.1";
        }];
      };
    };
    defaultGateway = {
      address = "172.16.103.1";
      interface = "vlan253";
    };
    nameservers = [ "172.16.103.238" ];
    search = [ "intr" "majordomo.ru" ];
    extraHosts = ''
      127.0.0.1 deprecated-jenkins.intr ci.guix.gnu.org.intr
    '';
  };

  time.timeZone = "Europe/Moscow";

  environment.systemPackages = with pkgs; [
    bind
    file
    findutils
    ripgrep
    gcc9
    gron
    htop
    iotop
    iputils
    jdk
    jq
    killall
    qemu_kvm
    netcat
    nettools
    nix-generate-from-cpan
    nix-prefetch-docker
    nix-prefetch-git
    nodejs
    parallel
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
    yarn
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

  imports = [
    ({ config, pkgs, ... }:
      let
        engSshPublicKey =
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDUrF2h4GoVEuYLhYpeLpwbWvqj+xbPGjNAu/Z6y5GlzZXUkvaPwayZooN+yyWFM4//V1VZkipFJqd+0seDoqDK+JaspZGxO/TqIUAVB7EoAscWWREqIJsC4e/00ki/8H0OQVxjlcx4d4DdXH0/vlb3dyLIbouKA3FRAh/dShyx/+joguero8DhM64/6z6UBT2mRbeKDxi8vdnhD6fvF4dNAdNtwEtsg//P+N32MHQiLZhfrCh+tlP6xovOckYZ9aaGbxRRxL/D1E3v7fzJApbruhPULCeMCM1P8f6CY287KaEgctFu3IsIBQqrSgYQ2cngs6YWlwHZtjCkIgRNKq3P+Lhw9Hvbg4QcYEKBYXtWqrF5/gmTjnLXeT2tvwFy3NjsS6Br6MwMPey2YzT84lP10xmFp7mhm9RPmDiEN/dQj4ykMGeMC80/mal0NbNALkBawrTxdGoJOELxCYG9oyFvxBCI/lvXY+1UGX19sSgOsaU1k6T7f2vyPu/915f35oeAnN9/B6NSOrdU8Vejy0FWrXEcEopt0aGWTK18/98E5nFdhvhclsXheFimvrZgA0FzqnScO3cXMGNOW1GwzTdf2TvzlLcJYybkMAkLm5E1kqqYD8khqdVP3YmU9LmeHOZEsTYzRSzsafBB2QmyD7UwrH++5kvH/N+yL+ywpTwkIw==";
      in
      {
        users = {
          mutableUsers = false;
          users = {
            eng = {
              isNormalUser = true;
              extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
              openssh.authorizedKeys.keys = [ engSshPublicKey ];
              uid = 1000;
            };
            root.openssh.authorizedKeys.keys = [ engSshPublicKey ];
          };
        };
      })
    ({ config, pkgs, ... }: {
      users.mutableUsers = false;
      users.users.sup = {
        isNormalUser = true;
        #extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSb3E/mXF/oTKLDsF/zFmPow65vYMzXOr/+kifRzLSnni7vi3M5o1ofKxgdFPx7z7dj84lIcPs2njnfljPQaWhsgGUdGe3kCqHL05koP1gDd9w8dLvLdUbir+sLkNDEOxlSHMV+IXT/PA2aMl6u8w51ytkAGdj1bnBWlXjqgevf3gRwWqYQk55RJsWQV12jLaDKX06WyBT5VXKzWaVp85RuBWuBcF1wyQy7eWlXC83/0ZH56G9Fua0nSQcRWA2rPjN5YGrShf1iVccHyMpJki7OCt+vWIuvi0wFOmCE4B7ejFRLiIjgdNGF3aXykKHrZPW5WIMn7Ev/ooE7i/vBbEMecOYIqcSfp2D08W6H/1Q8wz4IEaoCjvLCoEjAey/sziauBNnJnYlQ79ff/7cFrMrSx4NGLEF210cr1qTGoMR1ABd1mAN9GP++a9XPLsLLhS6H9e8wnSotjcaAsrlV9N8PNUdI8cdU6Pv/cQX6IUWAe524ZpLfv1EUiRbG5x2gELa6NXgXy6frr1ZiiSWq6ctcRYYIi2AFKDZ9rh0Wr20IbzKzMZFHHsPNdG8fSy1pwaQ3geuR/3h/U7K1GERzicm6aZVwhCmCpInr89/yoDM6L6NVpqOfQSyLASR/L93APPLB+6Z+v/egl8KvKj8loU4MDsWCW1te00k/DYVjbpa2w=="
        ];
        uid = 1002;
      };
    })
    ({ config, lib, pkgs, ... }:
      {
        security.pki.certificates = [
          ''
            -----BEGIN CERTIFICATE-----
            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
            C17nt7CIsj9xIxtaQLPyGA==
            -----END CERTIFICATE-----
          ''
        ];
      })
    ({ config, ... }:

      {
        networking.timeServers = [
          "172.16.102.1"
          "172.16.103.1"
        ];
      })
  ];

  services.lldpd.enable = true;

  users.users.root.password = ""; # Empty password.

  programs.fup-repl = {
    enable = true;
  };

  programs.sysdig.enable = true;

  # Enable Guix daemon
  # https://guix.gnu.org/
  #
  # Getting substitutes from Tor
  # https://guix.gnu.org/cookbook/en/html_node/Getting-substitutes-from-Tor.html
  services.guix-binary = {
    enable = true;
    extraArgs = [
      "--substitute-urls=http://ci.guix.gnu.org.intr"
    ];
  };
  services.tor = {
    enable = true;
    settings = {
      HTTPTunnelPort = 9250;
      ExitNodes = "{nl},{fr},{de}";
      DNSPort = 53;
      AutomapHostsOnResolve = true;
    };
  };
  services.kresd = {
    enable = true;
    extraConfig = builtins.readFile ./../kresd.conf;
  };
  systemd.services.tinyproxy = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = lib.concatStringsSep " " [
        "${pkgs.tinyproxy}/bin/tinyproxy" "-d" "-c" ./../tinyproxy.conf
      ];
    };
  };
  systemd.services.socat = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = lib.concatStringsSep " " [
        "${pkgs.socat}/bin/socat"
        "tcp4-LISTEN:81,reuseaddr,fork,keepalive,bind=127.0.0.1"
        "SOCKS4A:127.0.0.1:4zwzi66wwdaalbhgnix55ea3ab4pvvw66ll2ow53kjub6se4q2bclcyd.onion:443,socksport=9050"
      ];
    };
  };
  services.nginx = {
    enable = true;
    upstreams = {
      onion = {
        servers = { "172.16.103.238:8888" = {}; };
      };
      socat = {
        servers = { "127.0.0.1:81" = {}; };
      };
    };
    virtualHosts."ci.guix.gnu.org.intr" = {
      locations."/" = {
        proxyPass = "https://socat";
        extraConfig = ''
          proxy_ssl_verify off;
        '';
      };
    };
  };

  services.kubernetes = {
    clusterCidr = "10.0.0.0/14";
    apiserver = {
      serviceClusterIpRange = "10.8.0.0/16";
    };
    kubelet = {
      clusterDns = "10.8.255.254";
    };
  };

  services.kubernetes-ha-node = {
    enable = true;
    bindAddress = "172.16.103.238";
    kubevirt = true;
    kubeApiServerAddress = "172.16.103.137";
    kubeApiServerDnsName = "kubernetes.intr";
    certificates = inputs.ssl-certificates.lib.ssl;
    hostName = "kube17";
  };

  services.kubernetes.kubelet = {
    hostname = "kube17";
    extraOpts = "--node-labels kubevirt.cluster.local/schedulable=true";
  };

  services.majordomo-containerd = {
    bindAddress = "172.16.103.238";
  };
}
