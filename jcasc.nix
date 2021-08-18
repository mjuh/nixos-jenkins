{ pkgs }:

{
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
              token = "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_PERSONAL_ACCESS_TOKEN}";
              scope = "GLOBAL";
            };
          }

          {
            basicSSHUserPrivateKey = {
              description = "jenkins-ssh-deploy";
              id = "jenkins-ssh-deploy";
              privateKeySource = {
                directEntry = {
                  privateKey = "\${readFile:/var/lib/jenkins/.ssh/id_rsa}";
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
              path = "secret/vaultPass/cfssl.intr";
              vaultKey = "password";
              engineVersion = 2;
              id = "OFFICE_SSL-CERTIFICATES";
              scope = "GLOBAL";
            };
          }

          {
            vaultStringCredentialImpl= {
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
    nodes = [
      {
        permanent = {
          labelString = "restic backup";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "bareos.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "bareos";
          nodeDescription = "bareos";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "pxe elk";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "chef-server.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "chef-server";
          nodeDescription = "chef-server";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dhost-production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "dh1.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
              javaPath = "/usr/bin/java";
            };
          };
          name = "dh1";
          nodeDescription = "dh1";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "js";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "ci.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "ci";
          nodeDescription = "ci";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dhost-production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "dh2.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
              javaPath = "/usr/bin/java";
            };
          };
          name = "dh2";
          nodeDescription = "dh2";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dhost-production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "dh3.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
              javaPath = "/usr/bin/java";
            };
          };
          name = "dh3";
          nodeDescription = "dh3";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dhost-development";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "dh4.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
              javaPath = "/usr/bin/java";
            };
          };
          name = "dh4";
          nodeDescription = "dh4";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dhost-development";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "dh5.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
              javaPath = "/run/current-system/sw/bin/java";
            };
          };
          name = "dh5";
          nodeDescription = "dh5";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "elk";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "fluentd.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "fluentd";
          nodeDescription = "fluentd ELK server";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "hms01.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "hms01";
          nodeDescription = "hms01";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "hms02.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "hms02";
          nodeDescription = "hms02";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "hms03.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "hms03";
          nodeDescription = "hms03";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm1.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm1";
          nodeDescription = "kvm1";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm10.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm10";
          nodeDescription = "kvm10";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic kvm-template-builder";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm11.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm11";
          nodeDescription = "kvm11";
          numExecutors = 5;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 120;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm12.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm12";
          nodeDescription = "kvm12";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm13.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm13";
          nodeDescription = "kvm13";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm14.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm14";
          nodeDescription = "kvm14";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvm-template-builder";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm15.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm15";
          nodeDescription = "kvm15";
          numExecutors = 10;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 120;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm16.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm16";
          nodeDescription = "kvm16";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm17.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm17";
          nodeDescription = "kvm17";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm19.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm19";
          nodeDescription = "kvm19";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm2.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm2";
          nodeDescription = "kvm2";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm20.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm20";
          nodeDescription = "kvm20";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm21.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm21";
          nodeDescription = "kvm21";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm22.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm22";
          nodeDescription = "kvm22";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm23.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm23";
          nodeDescription = "kvm23";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm24.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm24";
          nodeDescription = "kvm24";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm25.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm25";
          nodeDescription = "kvm25";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm26.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm26";
          nodeDescription = "kvm26";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm27.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm27";
          nodeDescription = "kvm27";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm28.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm28";
          nodeDescription = "kvm28";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm29.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm29";
          nodeDescription = "kvm29";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm30.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm30";
          nodeDescription = "kvm30";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm31.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm31";
          nodeDescription = "kvm31";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm32.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm32";
          nodeDescription = "kvm32";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm33.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm33";
          nodeDescription = "kvm33";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm34.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm34";
          nodeDescription = "kvm34";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm35.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm35";
          nodeDescription = "kvm35";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm36.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm36";
          nodeDescription = "kvm36";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm37.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm37";
          nodeDescription = "kvm37";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm5.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm5";
          nodeDescription = "kvm5";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm6.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm6";
          nodeDescription = "kvm6";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm kvmbionic";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "kvm9.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "kvm9";
          nodeDescription = "kvm9";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm-template-builder";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "mx1-mr.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "mx1-mr";
          nodeDescription = "mx1-mr";
          numExecutors = 2;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 120;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "kvm-template-builder prometheus-server";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "mx2-mr.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "mx2-mr";
          nodeDescription = "mx2-mr";
          numExecutors = 2;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 120;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "mail-production webmail-mr smtp-out";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "webmail1-mr.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "webmail1-mr";
          nodeDescription = "webmail1-mr";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "mail-production webmail-mr smtp-out";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "webmail2-mr.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "webmail2-mr";
          nodeDescription = "webmail2-mr";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "nginx-mr";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "nginx1.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "nginx1";
          nodeDescription = "nginx1";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 120;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "nginx-mr";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "nginx2.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "nginx2";
          nodeDescription = "nginx2";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 120;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dns-production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "ns1-dh.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "ns1-dh";
          nodeDescription = "ns1-dh";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dns-production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "ns1-mr.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "ns1-mr";
          nodeDescription = "ns1-mr";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dns-production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "ns2-dh.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "ns2-dh";
          nodeDescription = "ns2-dh";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "dns-production";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "ns2-mr.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "ns2-mr";
          nodeDescription = "ns2-mr";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "pop";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "pop1.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "pop1";
          nodeDescription = "pop1";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "pop pop-nix";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "pop2.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "pop2";
          nodeDescription = "pop2";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "pop elk";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "pop5.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "pop5";
          nodeDescription = "pop5";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web15.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web15";
          nodeDescription = "web15";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web16.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web16";
          nodeDescription = "web16";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web17.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web17";
          nodeDescription = "web17";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web18.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web18";
          nodeDescription = "web18";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web19.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web19";
          nodeDescription = "web19";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web20.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web20";
          nodeDescription = "web20";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web21.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web21";
          nodeDescription = "web21";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web22.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web22";
          nodeDescription = "web22";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web23.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web23";
          nodeDescription = "web23";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web25.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web25";
          nodeDescription = "web25";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web26.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web26";
          nodeDescription = "web26";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web27.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web27";
          nodeDescription = "web27";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web28.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web28";
          nodeDescription = "web28";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web29.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web29";
          nodeDescription = "web29";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web30.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web30";
          nodeDescription = "web30";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web31.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web31";
          nodeDescription = "web31";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web32.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web32";
          nodeDescription = "web32";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web33.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web33";
          nodeDescription = "web33";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web34.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web34";
          nodeDescription = "web34";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web35.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web35";
          nodeDescription = "web35";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web36.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web36";
          nodeDescription = "web36";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
      {
        permanent = {
          labelString = "web";
          launcher = {
            ssh = {
              credentialsId = "jenkins-ssh-deploy";
              host = "web37.intr";
              port = 22;
              sshHostKeyVerificationStrategy =
                "knownHostsFileKeyVerificationStrategy";
            };
          };
          name = "web37";
          nodeDescription = "web37";
          numExecutors = 1;
          remoteFS = "/home/jenkins";
          retentionStrategy = {
            demand = {
              idleDelay = 1;
              inDemandDelay = 0;
            };
          };
        };
      }
    ];
    numExecutors = 21;
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
            password = "\${DATA_VAULTPASS_MAJORDOMO_JENKINS.INTR_PASSWORD}";
          }
          {
            id = "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_USERNAME}";
            password = "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_PASSWORD}";
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
      healthMetrics = [{ worstChildHealthMetric = { recursive = true; }; }];
    };
    gitLabServers = {
      servers = [{
        credentialsId = "gitlab-personal-access-token";
        manageWebHooks = true;
        name = "gitlab.intr";
        serverUrl = "https://gitlab.intr";
        secretToken = "\${DATA_VAULTPASS_MAJORDOMO_GITLAB.INTR_PERSONAL_ACCESS_TOKEN}";
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
      declaredResources = [{
        description = "";
        labels = "";
        name = "git@gitlab.intr:_ci/docker-stacks.git";
        reservedBy = "";
      }];
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
  jobs = [ { file = ./jobs.groovy; } ];
}
