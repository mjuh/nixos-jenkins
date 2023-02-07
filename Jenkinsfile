deployRS(
    scanPasswords: true,
    deploy: true,
    flake: ".#jenkins.system",
    preBuild: {
        nixFlakeLockUpdate (inputs: ["kvm"])
        sh "nix build --print-build-logs .#nixosConfigurations.jenkins.config.system.build.toplevel"
    },
    postBuild: {
        if (env.GIT_BRANCH != "master") {
            sh '''
               mkdir -p build
               nix run .#jenkins-update-plugins | tee build/plugins.nix
               (
                   set +e
                   diff -u plugins.nix build/plugins.nix > build/plugins.nix.diff
                   exit 0
               )
            '''
            dir("build") {
                archiveArtifacts artifacts: "plugins.nix.diff"
                archiveArtifacts artifacts: "plugins.nix"
                sh "rm plugins.nix plugins.nix.diff"
            }
            sh "rmdir build"
        }
    }
    postDeploy: {
        sh "rm --force /var/lib/jenkins/.ssh/known_hosts; nix-shell --run 'deploy .#jenkins.jenkins -- --print-build-logs'"
    }
)
