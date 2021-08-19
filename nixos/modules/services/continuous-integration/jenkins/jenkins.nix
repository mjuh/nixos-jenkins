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
    jcasc = lib.mkOption {
      type = types.attrs;
      default = {
        credentials = {
          system = {
            domainCredentials = [{
              credentials = [
                {
                  vaultAppRoleCredential = {
                    description = "Vault AppRole Pull Authentication";
                    id = "vault-approle-pull-authentication";
                    path = "approle";
                    roleId = "\${VAULT_ROLE_ID}";
                    scope = "GLOBAL";
                    secretId = "\${VAULT_SECRET_ID}";
                  };
                }

                {
                  gitlabPersonalAccessToken = {
                    description = "gitlab.intr personal access token";
                    id = "gitlab-personal-access-token";
                    token =
                      "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_PERSONAL_ACCESS_TOKEN}";
                    scope = "GLOBAL";
                  };
                }

                # Same as gitlabPersonalAccessToken but a type which works
                # with "credentials()" in Jenkins Groovy DSL.
                {
                  vaultStringCredentialImpl = {
                    description = "gitlab.intr personal access token";
                    path = "secret/vaultPass/majordomo/gitlab.intr";
                    vaultKey = "personal-access-token";
                    engineVersion = 2;
                    id = "GITLAB_JENKINS_API_KEY";
                    scope = "GLOBAL";
                  };
                }

                {
                  basicSSHUserPrivateKey = {
                    description = "jenkins-ssh-deploy";
                    id = "jenkins-ssh-deploy";
                    privateKeySource = {
                      directEntry = {
                        privateKey =
                          "\${readFile:/var/lib/jenkins/.ssh/id_rsa}";
                      };
                    };
                    scope = "GLOBAL";
                    username = "jenkins";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "SLACK_API_KEY";
                    path = "secret/vaultPass/majordomo/mjru.slack.com";
                    vaultKey = "api-key";
                    engineVersion = 2;
                    id = "SLACK_API_KEY";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "Migrated slack token";
                    path = "secret/vaultPass/majordomo/mjru.slack.com";
                    vaultKey = "token";
                    engineVersion = 2;
                    id = "slack";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "Alerta API key";
                    path = "secret/vaultPass/majordomo/alerta.intr";
                    vaultKey = "api-key";
                    engineVersion = 2;
                    id = "ALERTA_KEY";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "OFFICE_SSL-CERTIFICATES";
                    path = "secret/vaultPass/majordomo/cfssl.intr";
                    vaultKey = "password";
                    engineVersion = 2;
                    id = "OFFICE_SSL-CERTIFICATES";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "CERBERUS_KEY";
                    path = "secret/vaultPass/majordomo/cerberus.intr";
                    vaultKey = "api-key";
                    engineVersion = 2;
                    id = "CERBERUS_KEY";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "CERBERUS_SECRET";
                    path = "secret/vaultPass/majordomo/cerberus.intr";
                    vaultKey = "api-secret";
                    engineVersion = 2;
                    id = "CERBERUS_SECRET";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "Majordomo HMS production API password";
                    path = "secret/vaultPass/majordomo/api.majordomo.ru";
                    vaultKey = "password";
                    engineVersion = 2;
                    id = "MJRU_API_PROD_PASSWORD";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "Majordomo HMS development API password";
                    path = "secret/vaultPass/majordomo/api-dev.intr";
                    vaultKey = "password";
                    engineVersion = 2;
                    id = "MJRU_API_DEV_PASSWORD";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "Majordomo HMS RabbitMQ password";
                    path = "secret/vaultPass/majordomo/rabbit.intr";
                    vaultKey = "password";
                    engineVersion = 2;
                    id = "RABBITMQ_PROD_PASSWORD";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "IPMI ADMIN password";
                    path = "secret/vaultPass/majordomo/jenkins.ipmi.intr";
                    vaultKey = "password";
                    engineVersion = 2;
                    id = "IPMI_PASSWORD";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultStringCredentialImpl = {
                    description = "Majordomo HMS Mongo password";
                    path = "secret/vaultPass/majordomo/hms01.intr";
                    vaultKey = "password";
                    engineVersion = 2;
                    id = "MONGO_PROD_PASSWORD";
                    scope = "GLOBAL";
                  };
                }

                {
                  vaultUsernamePasswordCredentialImpl = {
                    description = "Gradle user for nexus.intr";
                    engineVersion = 2;
                    id = "nexus";
                    passwordKey = "password";
                    path = "secret/vaultPass/majordomo/gradle.nexus.intr";
                    scope = "GLOBAL";
                    usernameKey = "username";
                  };
                }

                {
                  vaultUsernamePasswordCredentialImpl = {
                    description = "Jenkins user for nexus.intr";
                    engineVersion = 2;
                    id = "jenkinsnexus";
                    passwordKey = "password";
                    path = "secret/vaultPass/majordomo/jenkins.nexus.intr";
                    scope = "GLOBAL";
                    usernameKey = "username";
                  };
                }

                {
                  vaultUsernamePasswordCredentialImpl = {
                    description = "docker-registry.intr";
                    engineVersion = 2;
                    id = "docker-registry";
                    passwordKey = "password";
                    path = "secret/vaultPass/majordomo/docker-registry.intr";
                    scope = "GLOBAL";
                    usernameKey = "username";
                  };
                }

              ];
            }];
          };
        };
        jenkins = {
          agentProtocols = [ "JNLP4-connect" "Ping" ];
          authorizationStrategy = {
            loggedInUsersCanDoAnything = { allowAnonymousRead = true; };
          };
          disableRememberMe = false;
          globalNodeProperties = [{
            envVars = {
              env = [
                {
                  key = "ANDROID_HOME";
                  value = "/var/lib/jenkins/android-sdk";
                }
                {
                  key = "PATH";
                  value =
                    "/var/lib/jenkins/bin:/run/wrappers/bin:/var/lib/jenkins/.nix-profile/bin:/etc/profiles/per-user/jenkins/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/repo/sbin";
                }
              ];
            };
          }];
          labelString = "dh-docker-swarm-vm nixbld";
          markupFormatter = "plainText";
          mode = "NORMAL";
          nodes = [{
            permanent = {
              launcher = {
                ssh = {
                  credentialsId = "jenkins-ssh-deploy";
                  host = "localhost";
                  javaPath = "${pkgs.jdk}/bin/java";
                  port = 22;
                  sshHostKeyVerificationStrategy =
                    "nonVerifyingKeyVerificationStrategy";
                };
              };
              name = config.networking.hostName;
              nodeDescription = config.networking.hostName;
              numExecutors = 10;
              remoteFS = config.services.jenkins.home;
              retentionStrategy = {
                demand = {
                  idleDelay = 120;
                  inDemandDelay = 0;
                };
              };
            };
          }];
          numExecutors = 5;
          primaryView = { all = { name = "all"; }; };
          projectNamingStrategy = "standard";
          quietPeriod = 5;
          remotingSecurity = { enabled = true; };
          securityRealm = {
            local = {
              allowsSignup = false;
              users = [
                {
                  id = "\${DATA_VAULTPASS_MAJORDOMO_JENKINS.INTR_USERNAME}";
                  password =
                    "\${DATA_VAULTPASS_MAJORDOMO_JENKINS.INTR_PASSWORD}";
                }
                {
                  id = "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_USERNAME}";
                  password =
                    "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_PASSWORD}";
                }
                {
                  id = "chatops";
                  password =
                    "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_CHATOPS_PASSWORD}";
                }
              ];
            };
          };
          scmCheckoutRetryCount = 0;
          slaveAgentPort = 0;
          systemMessage = ''
              Welcome to our build server.

              This Jenkins is 100% configured and managed 'as code'.
            '';
          updateCenter = {
            sites = [{
              id = "default";
              url = "https://updates.jenkins.io/update-center.json";
            }];
          };
        };
        security = {
          apiToken = {
            creationOfLegacyTokenEnabled = false;
            tokenGenerationOnCreationEnabled = false;
            usageStatisticsEnabled = true;
          };
          globalJobDslSecurityConfiguration = { useScriptSecurity = true; };
          sSHD = { port = -1; };
          scriptApproval = {
            approvedSignatures = [
              "method groovy.json.JsonSlurperClassic parseText java.lang.String"
              "method java.io.File canRead"
              "method java.lang.String getBytes"
              "method java.net.URL openConnection"
              "method java.util.Collection remove java.lang.Object"
              "method java.util.Properties load java.io.InputStream"
              "new groovy.json.JsonSlurperClassic"
              "new java.io.File java.lang.String"
              "new java.util.Base64"
              "new java.util.Properties"
              "new java.util.Properties java.util.Properties"
              "staticMethod org.codehaus.groovy.runtime.DefaultGroovyMethods execute java.lang.String"
              "staticMethod org.codehaus.groovy.runtime.DefaultGroovyMethods newDataInputStream java.io.File"
              "staticMethod org.codehaus.groovy.runtime.DefaultGroovyMethods toInteger java.lang.Number"
              "staticMethod org.codehaus.groovy.runtime.ProcessGroovyMethods getText java.lang.Process"
            ];
          };
        };
        tool = with pkgs; {
          git = {
            installations = [{
              home = "git";
              name = "default";
            }];
          };
          gradle = {
            installations = [
              {
                home = gradle;
                name = "latest";
              }
              {
                home = gradle_4;
                name = "4";
              }
              {
                home = gradle_5;
                name = "5";
              }
              {
                home = gradle_6;
                name = "6";
              }
              {
                home = gradle_7;
                name = "7";
              }
            ];
          };
          jdk = {
            installations = [
              {
                home = openjdk;
                name = "latest";
              }
              {
                home = openjdk8;
                name = "8";
              }
              {
                home = pkgs.openjdk11;
                name = "11";
              }
            ];
          };
        };
        unclassified = {
          defaultFolderConfiguration = {
            healthMetrics =
              [{ worstChildHealthMetric = { recursive = true; }; }];
          };
          gitLabServers = {
            servers = [{
              credentialsId = "gitlab-personal-access-token";
              manageWebHooks = true;
              name = "gitlab.intr";
              serverUrl = "https://gitlab.intr";
              secretToken =
                "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_PERSONAL_ACCESS_TOKEN}";
            }];
          };
          gitSCM = {
            createAccountBasedOnEmail = false;
            showEntireCommitSummaryInChanges = false;
            useExistingAccountWithSameEmail = false;
          };
          globalLibraries = {
            libraries = [{
              defaultVersion = "master";
              implicit = true;
              name = "mj-shared-library";
              retriever = {
                modernSCM = {
                  scm = {
                    git = {
                      credentialsId = "jenkins-ssh-deploy";
                      id = "2647d22b-9c38-44a9-8593-46857caed7c8";
                      remote = "git@gitlab.intr:_ci/pipeline-shared-libs.git";
                      traits = [ "gitBranchDiscovery" ];
                    };
                  };
                };
              };
            }];
          };
          globalNexusConfiguration = {
            instanceId = "606fd072dd234a9ca2ada439be99c4ff";
            nxrmConfigs = [{
              nxrm3Configuration = {
                credentialsId = "nexus";
                displayName = "nexus.intr";
                id = "nexus.intr";
                internalId = "6557bd75-da66-424d-a346-4295ef73693d";
                serverUrl = "http://nexus.intr";
              };
            }];
          };
          hashicorpVault = {
            configuration = {
              engineVersion = 2;
              skipSslVerification = true;
              timeout = 60;
              vaultCredentialId = "vault-approle-pull-authentication";
              vaultUrl = "https://vault.intr";
            };
          };
          mailer = {
            authentication = {
              password = "\${DATA_VAULTPASS_MAJORDOMO_JENKINS.INTR_USERNAME}";
              username = "jenkins@majordomo.ru";
            };
            charset = "UTF-8";
            smtpHost = "smtp.majordomo.ru";
            useSsl = false;
          };
          location = {
            adminAddress = "jenkins@majordomo.ru";
            url = "https://jenkins.intr/";
          };
          lockableResourcesManager = {
            declaredResources = [
              {
                description = "";
                labels = "";
                name = "git@gitlab.intr:_ci/docker-stacks.git";
                reservedBy = "";
              }
              {
                description = "";
                labels = "";
                name = "docker-registry";
                reservedBy = "";
              }
            ];
          };
          mavenModuleSet = { localRepository = "default"; };
          pollSCM = { pollingThreadCount = 10; };
          slackNotifier = {
            botUser = false;
            room = "#git";
            sendAsText = false;
            teamDomain = "mjru";
            tokenCredentialId = "slack";
          };
        };
        jobs = [{ file = ../../../../../jobs.groovy; }];
      };
      description = "Jenkins builder nodes";
    };
  };

  config = lib.mkIf cfg.enable ({
    environment.systemPackages = with pkgs; [
      git
    ];

    users.users.jenkins.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1+OT1TqJB2P2waz+OsnXTNiQtuBVVsOuSAcNJD6rmnXLlZY2OYYvXlXbG3A9rJK403cjKRAebowEo9dk4LluwNFAN2M+0mym1eJTqCmTbATWp9btYV4U3skL+Za+H9c1Ms8/E8vmI8ze+W0evK5FiIm43PdTwiZ4Q9X6BDDcm+gTybwo4Vv3jw6kdVRCJNpX8C7Tx11KawmYjvUJ/sJMdJH+xiliiq6zL8m0xDOADcDABX47RQ9aOkNEID+QdNVIV57YcZ8LX3iaeq+kTxUkJROkwQUcep7Sx4KJZXkLGOAWPNcYLCMsoPnOpqSxqmHXCa1meWjmvwkR/7Pxvm0P7"
    ];

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
        CASC_JENKINS_CONFIG =
          toString (pkgs.writeText "jenkins.yml" (builtins.toJSON cfg.jcasc));
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
