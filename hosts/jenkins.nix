{ config, pkgs, lib, options, inputs, system, ... }: {
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
    zabbix-agent ALL=(ALL:ALL) NOPASSWD:ALL
    veretelnikov ALL=(ALL:ALL) NOPASSWD:ALL
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
        { name = "jenkinsci"; }
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
      jcasc = options.services.ci.jcasc.default // {
        jenkins = options.services.ci.jcasc.default.jenkins // {
          nodes = (options.services.ci.jcasc.default.jenkins.nodes ++ (map
            (host: {
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
                    idleDelay = 10;
                    inDemandDelay = 0;
                  };
                };
              };
            }))
            ([
              {
                labelString = "restic backup";
                name = "bareos";
              }
              {
                labelString = "pxe";
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
                labelString = "prometheus-server";
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
                labelString = "pop";
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
              {
                labelString = "logstash";
                name = "deprecated-web32";
              }
              {
                labelString = "logstash";
                name = "deprecated-web20";
              }
              {
                labelString = "logstash";
                name = "ns2-dh";
              }
              {
                labelString = "logstash";
                name = "vm35";
              }
              {
                labelString = "logstash";
                name = "es2";
              }
            ]

            ++
            (map
              (name: {
                labelString = if (builtins.elem name ["kvm15"])
                              then
                                "kvm"
                              else
                                "kvm kvmbionic";
                inherit name;
              })
              (lib.attrNames inputs.kvm.nixosConfigurations))));
        };
      };
    };

    jenkins = {
      packages = with pkgs; [
        bats
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
    hostName = "jenkins";
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
      127.0.0.1 jenkins.intr ci.guix.gnu.org.intr
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

  disabledModules = [ "services/monitoring/zabbix-agent.nix" ];
  imports = with inputs.nix-flake-common.nixosModules; [
    zabbix-agent
    mjzabbix
    mj-smartd
    eng
    sup
    security
    inputs.nix-flake-common.nixosModules.ntp
  ];

  services.lldpd.enable = true;

  users.users.root.password = ""; # Empty password.

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

  programs.fup-repl = {
    enable = true;
  };

  programs.sysdig.enable = true;
}
