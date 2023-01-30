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
                sh "nix build .#nixosConfigurations.jenkins.config.system.build.toplevel"
            }
        }
    }
}
