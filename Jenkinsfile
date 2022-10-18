pipeline {
    agent { label "jenkins" }
    options {
        buildDiscarder(logRotator(numToKeepStr: '2', artifactNumToKeepStr: '2'))
    }
    stages {
        stage("build") {
            steps {
                sh "nix-shell --run 'nix build --print-build-logs .#default'"
            }
        }
        stage("release") {
            steps {
                script {
                    def result = (sh (script: "readlink -f result/nixos.qcow2", returnStdout: true)).trim()
                    sh "cp ${result} nixos.qcow2"
                    archiveArtifacts artifacts: "nixos.qcow2"
                }
            }
        }
    }
    post {
        success {
            cleanWs()
        }
    }
}
