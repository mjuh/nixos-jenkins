deployRS(scanPasswords: true,
         deploy: true,
         flake: ".#jenkins.system",
         postDeploy: {
           sh "rm /var/lib/jenkins/.ssh/known_hosts; nix-shell --run 'deploy .#jenkins.jenkins -- --print-build-logs'"
         })
