deployRS(
    scanPasswords: true,
    deploy: true,
    flake: ".#jenkins.system",
    preBuild: { nixFlakeLockUpdate (inputs: ["kvm"]) },
    postTests: {
        if (env.BRANCH_NAME != "master") {
            sh '''
                  nix run .#jenkins-update-plugins | tee plugins.1.nix
                  (
                      set +e
                      diff -u plugins.1.nix plugins.nix > plugins.nix.diff
                      exit 0
                  )
               '''
            archiveArtifacts artifacts: "plugins.nix.diff"
            archiveArtifacts artifacts: "plugins.1.nix"
        }
    },
    postDeploy: {
        sh "rm --force /var/lib/jenkins/.ssh/known_hosts; nix-shell --run 'deploy .#jenkins.jenkins -- --print-build-logs'"
    },
    always: {
        sh "rm -f plugins.1.nix plugins.nix.diff"
    }
)
