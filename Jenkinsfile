deployRS(scanPasswords: true,
         deploy: true,
         flake: ".#jenkins.system",
         preBuild: { nixFlakeLockUpdate (inputs: ["kvm"]) },
         postDeploy: {
           sh "rm --force /var/lib/jenkins/.ssh/known_hosts; nix-shell --run 'deploy .#jenkins.jenkins -- --print-build-logs'"
         })
