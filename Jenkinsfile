pipeline {
    agent { label "jenkins" }
    options  {
        buildDiscarder(logRotator(numToKeepStr: "10",
                                  artifactNumToKeepStr: "10"))
        disableConcurrentBuilds()
        quietPeriod(env.BRANCH_NAME == "master" ? 5 : 0)
    }
    stages {
        stage("build") {
            steps {
                sh "nix build --print-build-logs .#nixosConfigurations.jenkins.config.system.build.toplevel"
            }
        }
        stage("plugins") {
            when {
                not { branch "master" }
                beforeAgent true
            }
            steps {
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
    }
}
