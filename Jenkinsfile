deployRS(scanPasswords: true,
         deploy: true,
         flake: ".#jenkins.system",
         postDeploy: {
           sh "rm /var/lib/jenkins/.ssh/known_hosts; nix-shell --run 'deploy --print-build-logs .#jenkins.jenkins'"
         })
