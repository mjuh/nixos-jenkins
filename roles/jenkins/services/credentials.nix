{ inputs, pkgs, lib, jenkinsCurl, jenkinsUrl, plugins ? false }:

let
  inherit (builtins) getEnv;
  inherit (lib) optionals;

  inherit (inputs.nix-flake-common.overlay {} pkgs) credentials;

  sshPrivateKey = credentials.SSH_JENKINS_DEPLOY;

  jenkinsCreateCredentialsSecret = { id, description, secret }:
    jenkinsCurl ''
      -X POST "${jenkinsUrl}/credentials/store/system/domain/_/createCredentials" \
      --data-urlencode 'json={
          "": "8",
          "credentials": {
            "scope": "GLOBAL",
            "secret": "${secret}",
            "$redact": "secret",
            "id": "${id}",
            "description": "${description}",
            "stapler-class": "org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl",
            "$class": "org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl"
          }
      }'
    '';

  jenkinsCreateCredentialsUsernamePassword =
    { id, description, username, password }:
    jenkinsCurl ''
       -X POST "${jenkinsUrl}/credentials/store/system/domain/_/createCredentials" \
       --data-urlencode 'json={
        "": "7",
        "credentials": {
          "scope": "GLOBAL",
          "id": "${id}",
          "username": "${username}",
          "password": "${password}",
          "description": "${description}",
          "stapler-class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
        }
      }'
    '';
in [
  "mkdir --parents /var/lib/jenkins/.ssh"

  # XXX: Permission denied workaround.
  "cp --verbose ${sshPrivateKey} /var/lib/jenkins/.ssh/id_rsa || true"

  (jenkinsCreateCredentialsSecret {
    id = "slack";
    description = "Migrated slack token";
    secret = credentials.SLACK_TOKEN;
  })

  (jenkinsCreateCredentialsSecret {
    id = "ALERTA_KEY";
    description = "Alerta API key";
    secret = credentials.ALERTA_API_KEY;
  })

  (jenkinsCreateCredentialsSecret {
    id = "OFFICE_SSL-CERTIFICATES";
    description = "https://gitlab.intr/office/ssl-certificates/";
    secret = credentials.OFFICE_SSL_CERTIFICATES;
  })

  (jenkinsCreateCredentialsSecret {
    id = "GITLAB_JENKINS_API_KEY";
    description = "GITLAB_JENKINS_API_KEY";
    secret = credentials.GITLAB_JENKINS_API_KEY;
  })

  (jenkinsCreateCredentialsSecret {
    id = "CERBERUS_KEY";
    description = "CERBERUS_KEY";
    secret = credentials.CERBERUS_KEY;
  })

  (jenkinsCreateCredentialsSecret {
    id = "CERBERUS_SECRET";
    description = "CERBERUS_SECRET";
    secret = credentials.CERBERUS_SECRET;
  })

  (jenkinsCreateCredentialsSecret {
    id = "SLACK_API_KEY";
    description = "SLACK_API_KEY";
    secret = credentials.SLACK_API_KEY;
  })

  (jenkinsCreateCredentialsSecret {
    id = "MJRU_API_PROD_PASSWORD";
    description = "Majordomo HMS production API password";
    secret = credentials.MJRU_API_PROD_PASSWORD;
  })

  (jenkinsCreateCredentialsSecret {
    id = "MJRU_API_DEV_PASSWORD";
    description = "Majordomo HMS development API password";
    secret = credentials.MJRU_API_DEV_PASSWORD;
  })

  (jenkinsCreateCredentialsSecret {
    id = "RABBITMQ_PROD_PASSWORD";
    description = "Majordomo HMS RabbitMQ password";
    secret = credentials.RABBITMQ_PROD_PASSWORD;
  })

  (jenkinsCreateCredentialsSecret {
    id = "IPMI_PASSWORD";
    description = "IPMI ADMIN password";
    secret = credentials.IPMI_PASSWORD;
  })

  (jenkinsCreateCredentialsSecret {
    id = "MONGO_PROD_PASSWORD";
    description = "Majordomo HMS Mongo password";
    secret = credentials.MONGO_PROD_PASSWORD;
  })

  (jenkinsCreateCredentialsUsernamePassword {
    id = "apicredentials";
    description = "API credentials";
    username = credentials.JOB_BUILDER_USER;
    password = credentials.JOB_BUILDER_PASSWORD;
  })

  (jenkinsCreateCredentialsUsernamePassword {
    id = "jenkins";
    description = "Jenkins credentials for NGINX API";
    username = "jenkins";
    password = credentials.NGINX_DOCKER_STACK_SWITCH_PASSWORD;
  })

  (jenkinsCreateCredentialsUsernamePassword {
    id = "docker-registry";
    description = "docker-registry.intr";
    username = credentials.GRADLE_USER;
    password = credentials.GRADLE_PASSWORD;
  })

  (jenkinsCreateCredentialsUsernamePassword {
    id = "nexus";
    description = "Gradle user at nexus.intr";
    username = credentials.GRADLE_USER;
    password = credentials.GRADLE_PASSWORD;
  })

  (jenkinsCreateCredentialsUsernamePassword {
    id = "jenkinsnexus";
    description = "Jenkins user for nexus.intr";
    username = credentials.JENKINS_NEXUS_USER;
    password = credentials.JENKINS_NEXUS_PASSWORD;
  })
] ++ optionals plugins [
  (jenkinsCurl ''
       -X POST "${jenkinsUrl}/credentials/store/system/domain/_/createCredentials" \
       --data-urlencode 'json={
        "": "3",
        "credentials": {
          "scope": "GLOBAL",
          "id": "jenkins-ssh-deploy",
          "username": "jenkins",
          "password": "",
          "privateKeySource": {
            "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$DirectEntryPrivateKeySource",
            "privateKey": "${builtins.replaceStrings [ "\n" ] [ "\\n" ] (builtins.readFile sshPrivateKey)}",
          },
          "description": "Jenkins HMS-cluser credentials which are used to connect everywhere, not only HMS{1,2,3}",
          "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey"
        }
       }'
  '')

  (jenkinsCurl ''
       -X POST "${jenkinsUrl}/credentials/store/system/domain/_/createCredentials" \
       --data-urlencode 'json={
        "": "1",
        "credentials": {
           "scope": "GLOBAL",
           "apiToken": "${credentials.GITLAB_JENKINS_API_KEY}",
           "$redact": "apiToken",
           "id": "gitlab",
           "description": "Access to GitLab",
           "stapler-class": "com.dabsquared.gitlabjenkins.connection.GitLabApiTokenImpl",
           "$class": "com.dabsquared.gitlabjenkins.connection.GitLabApiTokenImpl"
        }
      }'
  '')

  (jenkinsCurl ''
       -X POST "${jenkinsUrl}/credentials/store/system/domain/_/createCredentials" \
       --data-urlencode 'json={
        "": "2",
        "credentials": {
          "scope": "GLOBAL",
          "id": "gitlab-git",
          "username": "git",
          "password": "",
          "privateKeySource": {
            "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$DirectEntryPrivateKeySource",
            "privateKey": "${builtins.replaceStrings [ "\n" ] [ "\\n" ] (builtins.readFile sshPrivateKey)}",
          },
          "description": "Add Gitlab Git username and SSH key.",
          "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey"
        }
      }'
  '')


]
