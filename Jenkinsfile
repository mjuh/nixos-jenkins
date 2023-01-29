pipeline {
    agent { label "jenkins" }
    options  {
        buildDiscarder(logRotator(numToKeepStr: "10",
                                  artifactNumToKeepStr: "10"))
        disableConcurrentBuilds()
    }
    stages {
        stage("build") {
            steps {
                sh "nix-shell --run 'nix build --max-silent-time 10800 --print-build-logs .#default'"
            }
        }
        stage("release") {
            steps {
                script {
                    def result = (sh (script: "readlink -f result", returnStdout: true)).trim()
                    dir(result) {
                        archiveArtifacts artifacts: "nixos.qcow2"
                    }
                }
            }
        }
        stage("plugins") {
            when {
                not { branch "master" }
                beforeAgent true
            }
            steps {
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
        }
    }
    post {
        always {
            sh "rm -f plugins.1.nix plugins.nix.diff"
        }
    }
}
