deployRS(scanPasswords: true,
         deploy: { args ->
           sh "rm /var/lib/jenkins/.ssh/known_hosts; nix-shell --run 'deploy --print-build-logs .#jenkins.jenkins'"
         })
