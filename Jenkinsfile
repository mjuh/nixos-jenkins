def deployPhase(args) {
    node("jenkins") {
        sh "rm --verbose /var/lib/jenkins/.ssh/known_hosts"
        sh "deploy .#jenkins.jenkins -- --print-build-logs"
    }
}

deployRS(deployPhase: deployPhase, scanPasswords: true)
