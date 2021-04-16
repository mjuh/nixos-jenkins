{ config, lib, pkgs, inputs, system, ... }:

let 
  inherit (builtins) getEnv;
  inherit (lib) concatStringsSep;
  inherit (pkgs) jenkins-jcasc-config jenkins-jobs-config;

  inherit (inputs.nix-flake-common.overlay {} pkgs) credentials;

  user-jenkins = credentials.JENKINS_USER;
  password-jenkins = credentials.JENKINS_PASSWORD;

  jenkinsUrl = "http://${toString config.services.jenkins.listenAddress}:${
      toString config.services.jenkins.port
    }";

  jplugins = import ../plugins.nix { inherit (pkgs) fetchurl stdenv; };
  plugins = true;

  jenkinsJobsCommand = args:
    let commandArgs = if (args == []) then "$@" else builtins.concatStringsSep " " args; in
    "jenkins-jobs --user ${user-jenkins} --password ${password-jenkins} --ignore-cache ${commandArgs}";

  jenkinsCurl = args: ''
    ${pkgs.curl.bin}/bin/curl --user ${user-jenkins}:${password-jenkins} \
        --silent --connect-timeout 15 --max-time 19 --retry 3 --fail \
        --show-error ${args}
  '';

in {

  nix = {
    trustedUsers = [ "jenkins" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.etc."containers/policy.json" = {
    text = builtins.toJSON {
      default = [
        { type = "insecureAcceptAnything"; }
      ];
      transports = {
        docker-daemon = {
          "" = [
            { type = "insecureAcceptAnything"; }
          ];
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    jenkins-jcasc-config jenkins-job-builder jenkins-jobs-config

    (stdenv.mkDerivation {
      name = "jenkins-jobs-update";
      builder = writeScript "builder.sh" (''
        source $stdenv/setup
        mkdir -p $out/bin
        cat > $out/bin/jenkins-jobs-update <<'EOF'
        #!${bash}/bin/bash -e
        ${jenkinsJobsCommand []}
        EOF
        chmod 555 $out/bin/jenkins-jobs-update
      '');
    })

  ];
  
  services.jenkins = {
    enable = true;
    port = 8080;
    listenAddress = "127.0.0.1";
    user = "jenkins";
    extraGroups = [ "docker" "users" "adbusers" "kvm" ];
    packages = (with pkgs; [
      bashInteractive
      bats
      bind
      config.programs.ssh.package
      curl
      docker
      git
      jdk
      jdk
      kvm
      nix
      nodejs
      packer
      skopeo
      stdenv
      utillinux
    ]) ++ (with inputs.majordomo.packages.${system}; [
      influxdb-subscription-cleaner
    ]);
    extraJavaOptions = [
      "-Djenkins.install.runSetupWizard=false"
      "-Dorg.jenkinsci.plugins.durabletask.BourneShellScript.LAUNCH_DIAGNOSTICS=true"
      "-Dorg.jenkinsci.plugins.durabletask.BourneShellScript.HEARTBEAT_CHECK_INTERVAL=86400"

      # TODO: Avoid disable crumb
      # - [[https://www.jenkins.io/doc/book/managing/security/#disable-csrf-checking][Managing Security]]
      # - [[https://www.jenkins.io/doc/upgrade-guide/2.176/#SECURITY-626][Upgrading to Jenkins LTS 2.176.x]]
      # - [[https://www.jenkins.io/doc/upgrade-guide/2.222/#always-enabled-csrf-protection][Upgrading to Jenkins LTS 2.222.x]]
      # - [[https://www.jenkins.io/doc/book/managing/security/#caveats][Managing Security]]
      "-Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true"
    ];

    # XXX: Make sure this doesn't need and delete
    # plugins = import ../jenkinsPlugins.nix  { inherit (pkgs) fetchurl stdenv; };

    jobBuilder = {
      enable = true;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: rec {
    # TODO: androidemu = pkgs.callPackage ../ci/jenkins/androidemu {};
    jenkins-jcasc-config = pkgs.callPackage ../ci/jenkins/JCasC { };
    jenkins-jobs-config =
      pkgs.callPackage ../ci/jenkins/jenkins-jobs-config { };
  };

  systemd.services = {
    jenkins-job-builder = {
      enable = true;
      serviceConfig.TimeoutStartSec = "10min";
      script = ''
      sleep infinity
    '';
      after = [ "jenkins-credentials.service" ];
      wantedBy = [ "jenkins.service" ];
      preStart = ''
        rm -rf ${config.services.jenkins.home}/.cache/jenkins_jobs ;
        mkdir --parents /var/lib/jenkins

        # TODO: Create /var/lib/jenkins/.nix-profile -> /run/current-system/sw symlink.
        # [[ -a /run/current-system/sw ]] || ln -s /run/current-system/sw /var/lib/jenkins/.nix-profile
        # chown -R ${config.services.jenkins.user}:${config.services.jenkins.user} ${config.services.jenkins.home}/.nix-profile
    '';
      postStart = concatStringsSep "\n" [
        (jenkinsJobsCommand [
          "test"
          "${jenkins-jobs-config.out}/bin/folders.yml"
        ])

        (jenkinsJobsCommand [
          "update"
          "${jenkins-jobs-config.out}/bin/folders.yml"
        ])

        ''
          echo "Add Jenkins jobs."
          for job in ${jenkins-jobs-config.out}/bin/*.yml ; do ${
            jenkinsJobsCommand [ "test" "$job" ]
          } && ${jenkinsJobsCommand [ "update" "$job" ]}; done
        ''

        # XXX: Allow unfree
        "mkdir -p ${config.services.jenkins.home}/.config/nixpkgs/"
        "echo '{ allowUnfree = true; }' > ${config.services.jenkins.home}/.config/nixpkgs/config.nix"

        ''
          echo "TODO: Stop all jobs."
          for attempt in 3 2 1
          do
              sleep 30
              echo "Stop all jobs."
              ${jenkinsCurl "--data-urlencode \"script=$(< ${../scripts/jenkins-stop-all-jobs.groovy})\" ${jenkinsUrl}/scriptText"}
          done
        ''
      ];
    };

    jenkins-credentials = {
      enable = true;
      after = [ "jenkins.service" ];
      wantedBy = [ "jenkins.service" ];
      serviceConfig = {
        Type = "oneshot";
        User = "jenkins";
      };
      script = concatStringsSep "\n"
        ([ "set -x" ] ++ (import ./credentials.nix {
          inherit inputs pkgs lib plugins jenkinsCurl jenkinsUrl;
        }));
    };
    
    jenkins = {
      environment.CASC_JENKINS_CONFIG = "/etc/jenkins";
      preStart = let
        replacePlugins = if jplugins == null then
          ""
                         else
                           let
                             pluginCmds = lib.attrsets.mapAttrsToList (n: v:
                               "cp --recursive ${v}/*pi ${config.services.jenkins.home}/plugins/${v.name}.jpi")
                               jplugins;
                           in ''
          mkdir --mode=700 --parents /etc/jenkins
          test `stat -c %a /etc/jenkins` = "700" || chmod 700 /etc/jenkins
          cp --recursive ${pkgs.jenkins-jcasc-config}/* /etc/jenkins
          cat > /etc/jenkins/security.yml <<'EOF'
          jenkins:
            securityRealm:
              local:
                allowsSignup: false
                users:
                 - id: ${user-jenkins}
                   password: ${password-jenkins}
                 - id: ${credentials.GITLAB_USER}
                   password: ${credentials.GITLAB_PASSWORD}
                 - id: ${credentials.CHATOPS_USER}
                   password: ${credentials.CHATOPS_PASSWORD}
          unclassified:
            mailer:
              authentication:
                password: ${password-jenkins}
                username: "jenkins@majordomo.ru"
              charset: "UTF-8"
              smtpHost: "smtp.majordomo.ru"
              useSsl: false
          EOF
          chown --recursive jenkins: /etc/jenkins
          chmod 600 /etc/jenkins/*.yml
          rm --force --recursive ${config.services.jenkins.home}/plugins
          mkdir --parents ${config.services.jenkins.home}/plugins
          rm --force --recursive /var/lib/jenkins/.cache/jenkins_jobs/
          chown --recursive ${config.services.jenkins.user}:${config.services.jenkins.user} ${config.services.jenkins.home}
          ${lib.strings.concatStringsSep "\n" pluginCmds}
        '';
      in ''
      rm -rf ${config.services.jenkins.home}/war
      ${replacePlugins}
    '';
      serviceConfig = {
        TimeoutStartSec = "10min";
        OOMScoreAdjust = "-1000";
        PermissionsStartOnly = true;
      };
    };
  };
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
}
