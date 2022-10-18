{ config, pkgs, lib, options, inputs, system, ... }: {
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

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
    hostName = "jenkins";
    firewall.enable = false;
    useDHCP = true;
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

  imports = with inputs.nix-flake-common.nixosModules; [
    eng
    sup
    security
    inputs.nix-flake-common.nixosModules.ntp
  ];

  users.users.root.password = ""; # Empty password.

  programs.fup-repl = {
    enable = true;
  };

  programs.sysdig.enable = true;
}
