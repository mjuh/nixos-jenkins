{ config, lib, pkgs, inputs, system, ... }:

with lib;

let cfg = config.services.ci;
in {
  options.services.ci = {
    enable = lib.mkEnableOption "Enable ci service";
    gitlabGroups = lib.mkOption {
      type = with types; listOf attrs;
      default = { };
      description = "List of GitLab groups";
      example = literalExample ''
        gitlabGroups = [
          { name = "mygroup"; };
        ];
      '';
    };
  };

  config = lib.mkIf cfg.enable ({

    nix = {
      trustedUsers = [ config.users.users.jenkins.name ];
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    environment.etc."containers/policy.json" = {
      text = builtins.toJSON {
        default = [{ type = "insecureAcceptAnything"; }];
        transports = {
          docker-daemon = { "" = [{ type = "insecureAcceptAnything"; }]; };
        };
      };
    };

    services.jenkins = {
      environment = with builtins; {
        CASC_JENKINS_CONFIG = toString (pkgs.writeText "jenkins.yml"
          (builtins.toJSON (import ../../../../../jcasc.nix { inherit pkgs; })));
        SECRETS_FILE = "/run/secrets/jenkins.intr/jenkins.properties";
        GITLAB_GROUPS = builtins.concatStringsSep ","
          (map (group: group.name) cfg.gitlabGroups);
      };
      enable = true;
      port = 8080;
      listenAddress = "127.0.0.1";
      user = "jenkins";
      extraGroups = [ "docker" "users" "adbusers" "kvm" ];
      plugins =
        (import ../../../../../plugins.nix { inherit (pkgs) fetchurl stdenv; });
      packages = with pkgs; [
        bashInteractive
        config.programs.ssh.package
        curl
        docker
        git
        jdk
        kvm
        skopeo
        stdenv
        utillinux
      ];
      extraJavaOptions = [
        "-Djenkins.install.runSetupWizard=false"
        "-Dorg.jenkinsci.plugins.durabletask.BourneShellScript.LAUNCH_DIAGNOSTICS=true"
        "-Dorg.jenkinsci.plugins.durabletask.BourneShellScript.HEARTBEAT_CHECK_INTERVAL=86400"

        # XXX: Fix CSP for https://www.gnu.org/
        # https://www.jenkins.io/doc/book/security/configuring-content-security-policy/
        "-Dhudson.model.DirectoryBrowserSupport.CSP="

        # TODO: Avoid disable crumb
        # - [[https://www.jenkins.io/doc/book/managing/security/#disable-csrf-checking][Managing Security]]
        # - [[https://www.jenkins.io/doc/upgrade-guide/2.176/#SECURITY-626][Upgrading to Jenkins LTS 2.176.x]]
        # - [[https://www.jenkins.io/doc/upgrade-guide/2.222/#always-enabled-csrf-protection][Upgrading to Jenkins LTS 2.222.x]]
        # - [[https://www.jenkins.io/doc/book/managing/security/#caveats][Managing Security]]
        "-Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true"
      ];
    };

    security.pki.certificates = [
      (builtins.readFile "${
          inputs.ssl-certificates.packages.${system}.certificates
        }/Majordomo_LLC_Root_CA.crt")
    ];

    systemd.services.jenkins = {
      preStart = with config.services.jenkins; ''
        chown -R ${user}:${group} ${home}/plugins
      '';
      serviceConfig = {
        TimeoutStartSec = "10min";
        OOMScoreAdjust = "-1000";
        PermissionsStartOnly = true;
      };
    };

    vault-secrets = rec {
      # This applies to all secrets
      vaultPrefix = "secret/vaultPass/majordomo";
      vaultAddress = "https://vault.intr:443";

      secrets = {
        "jenkins.intr" = let
          secrets = pkgs.writeText "secrets" ''
            data/vaultPass/majordomo/gitlab.intr#username
            data/vaultPass/majordomo/gitlab.intr#password
            data/vaultPass/majordomo/gitlab.intr#chatops-password
            data/vaultPass/majordomo/gitlab.intr#personal-access-token
            data/vaultPass/majordomo/jenkins.intr#username
            data/vaultPass/majordomo/jenkins.intr#password
          '';
        in {
          secretsKey = "";
          services = [ "jenkins" ];
          user = config.users.users.jenkins.name;
          group = config.users.groups.jenkins.name;
          extraScript = with config.services.jenkins; ''
            mkdir -p ${home}/.ssh
            chown ${user}:${group} ${home}/.ssh
            base64 -d ${config.vault-secrets.outPrefix}/jenkins.intr/ssh-key > ${home}/.ssh/id_rsa
            chmod 400 ${home}/.ssh/id_rsa
            chown ${user}:${group} ${home}/.ssh/id_rsa

            cat ${
              config.vault-secrets.secrets."jenkins.intr".environmentFile
            } <(VAULT_ADDR=${vaultAddress} ${pkgs.vaultenv}/bin/vaultenv --no-inherit-env --secrets-file ${secrets} env) > "''${secretsPath}/jenkins.properties"
          '';
        };
      };
    };

    programs.ssh.knownHosts =
      import ../../../../../known_hosts.nix { inherit (pkgs) writeText; };

    services = {
      nginx = {
        enable = true;
        virtualHosts = {
          #https://wiki.jenkins.io/display/JENKINS/Running+Jenkins+behind+Nginx
          "jenkins.intr" = with inputs.ssl-certificates.packages.${system}; {
            addSSL = true;
            # forceSSL = true;
            sslCertificate = "${certificates}/ssl/jenkins.intr.pem";
            sslCertificateKey = "${certificates}/ssl/jenkins.intr.key";
            locations."/".proxyPass =
              "http://localhost:${toString config.services.jenkins.port}";
            locations."/".extraConfig = ''
              sendfile off;
              proxy_redirect     default;
              proxy_http_version 1.1;
              proxy_set_header   Host              $host;
              proxy_set_header   X-Real-IP         $remote_addr;
              proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for;
              proxy_set_header   X-Forwarded-Proto $scheme;
              proxy_max_temp_file_size 0;

              #this is the maximum upload size
              client_max_body_size       10m;
              client_body_buffer_size    128k;
              proxy_connect_timeout      90;
              proxy_send_timeout         90;
              proxy_read_timeout         90;
              proxy_buffering            off;
              proxy_request_buffering    off; # Required for HTTP CLI commands in Jenkins > 2.54
              proxy_set_header Connection ""; # Clear for keepalive
            '';
            locations."/userContent".extraConfig = ''
              root ${config.services.jenkins.home};
              if (!-f $request_filename){
                  #this file does not exist, might be a directory or a /**view** url
                  rewrite (.*) /$1 last;
                  break;
              }
              sendfile on;
            '';
          };
        };
      };
    };
  });
}
