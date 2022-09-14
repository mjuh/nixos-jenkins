@Library('mj-shared-library@wip') _
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
                script {
                    nginx.Switch("/hms")
                }
            }
        }
    }
}
