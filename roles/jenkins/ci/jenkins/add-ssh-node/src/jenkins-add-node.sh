#!/usr/bin/env bash

set -o nounset -o errexit -o pipefail

usage() {
    cat <<EOM
    Usage:
      $(basename $0) [OPTIONS]
      $(basename $0) [ -j | --jenkins-url | -n | --node-name | -s | -d | --desc | --slave-home | -e | --executors | -sh | --ssh-host | -sp | --ssh-port
                              | -c | --cred-id | -l | --labels | -u | --user-id | -p | --password | -h | --help ]
    Options:
      -j, --jenkins-url   Jenkins base URL.
      -d, --desc          Description.
      -n, --node-name     Node name.
      -s, --slave-home    Remote FS home.
      -e, --executors     No. of executors. Defaults to 1.
      -sh, --ssh-host     SSH host.
      -sp, --ssh-port     SSH port. Defaults to 22.
      -c, --cred-id       Credentials Id to use for SSH authentication.
      -l, --labels        Labels.
      -u, --user-id       Username for Jenkins authentication (and crumb retrieval).
      -p, --password      Password (or token) for Jenkins authentication (and crumb retrieval).
      -h, --help          Show usage.
    Example:
      $(basename $0) -j http://localhost:8080 -n dumb-slave-name -d node-desc -sh 127.0.0.1 -s /tmp/dumb-slave-home -c xxxx-xxxx -l dumb-slave-label -u admin -p admin
EOM
    exit 1
}

# Handle opts
[[ $# == 0 ]] && usage
while [[ $# > 0 ]]
do
  key="$1"
  case ${key} in
      -j|--jenkins-url)
        JENKINS_URL="${2}"
        shift
      ;;
      -n|--node-name)
        NODE_NAME="${2}"
        shift
      ;;
      -d|--desc)
        DESC="${2}"
        shift
      ;;
      -s|--slave-home)
        NODE_SLAVE_HOME="${2}"
        shift
      ;;
      -e|--executors)
        EXECUTORS="${2}"
        shift
      ;;
      -sh|--ssh-host)
        SSH_HOST="${2}"
        shift
      ;;
      -sp|--ssh-port)
        SSH_PORT="${2}"
        shift
      ;;
      -c|--cred-id)
        CRED_ID="${2}"
        shift
      ;;
      -l|--labels)
        LABELS="${2}"
        shift
      ;;
      -u|--user-id)
        USER_ID="${2}"
        shift
      ;;
      -p|--password)
        PASSWORD="${2}"
        shift
      ;;
      -h|--help)
        usage
      ;;
      *)
        echo "Error: Unknown arg: [${key}]"
        usage
      ;;
  esac
  shift
done

# Defaults
EXECUTORS=${EXECUTORS:-1}
SSH_PORT=${SSH_PORT:-22}
DESC=${DESC:-""}

# Print values
#printf "\nSelected values:\n"
_body=""
_body="${_body}\n JENKINS_URL \t: ${JENKINS_URL}"
_body="${_body}\n NODE_NAME \t: ${NODE_NAME}"
_body="${_body}\n DESC \t: ${DESC}"
_body="${_body}\n NODE_SLAVE_HOME \t: ${NODE_SLAVE_HOME}"
_body="${_body}\n EXECUTORS \t: ${EXECUTORS}"
_body="${_body}\n SSH_HOST \t: ${SSH_HOST}"
_body="${_body}\n SSH_PORT \t: ${SSH_PORT}"
_body="${_body}\n CRED_ID \t: ${CRED_ID}"
_body="${_body}\n LABELS \t: ${LABELS}"
#_body="${_body}\n USER_ID \t: ${USER_ID}"
#_body="${_body}\n PASSWORD \t: ${PASSWORD}"
#echo "$(printf "${_body}")" | column -s $'\t' -t 2>/dev/null

# Confirm
#read -r -p "Are you sure? [y/N]" response
#case ${response} in
#    [yY][eE][sS]|[yY])
#      printf "\nConfirmed.\n"
#      ;;
#    *)
#    printf "\nAborting!\n"
#      exit 0
#      ;;
#esac

# Check crumb
echo "Checking for CSRF..."
CRUMB=$(curl --fail -0 ''${JENKINS_URL}'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)' 2>/dev/null || echo "N/A")
if [[ ${CRUMB} != "N/A" ]]; then
  echo "CSRF Enabled."
else
  echo "CSRF not enabled."
fi

# Create node (doCreateItem)
RESPONSE=$(curl -L -s -o /dev/null -w "%{http_code}" -H "Content-Type:application/x-www-form-urlencoded" -H "$CRUMB" -X POST -d 'json={"name": "'"$NODE_NAME"'", "nodeDescription": "'"$DESC"'", "numExecutors": "'"$EXECUTORS"'", "remoteFS": "'"$NODE_SLAVE_HOME"'", "labelString": "'"$LABELS"'", "mode": "NORMAL", "": ["hudson.plugins.sshslaves.SSHLauncher", "hudson.slaves.RetentionStrategy$Demand"], "launcher": {"stapler-class": "hudson.plugins.sshslaves.SSHLauncher", "$class": "hudson.plugins.sshslaves.SSHLauncher", "host": "'"$SSH_HOST"'", "credentialsId": "'"$CRED_ID"'", "port": "'"$SSH_PORT"'", "javaPath": "", "jvmOptions": "", "prefixStartSlaveCmd": "", "suffixStartSlaveCmd": "", "launchTimeoutSeconds": "", "maxNumRetries": "", "retryWaitTime": ""}, "retentionStrategy": {"stapler-class": "hudson.slaves.RetentionStrategy$Demand", "$class": "hudson.slaves.RetentionStrategy$Demand"}, "nodeProperties": {"stapler-class-bag": "true"}, "type": "hudson.slaves.DumbSlave", "crumb": "'"$CRUMB"'"}' "${JENKINS_URL}/computer/doCreateItem?name=${NODE_NAME}&type=hudson.slaves.DumbSlave")

if [[ ${RESPONSE} == "200" ]]; then
  echo "SUCCESS"
else
  echo "ERROR: Failed to create node. Response code: [${RESPONSE}]"
  exit 1
fi
