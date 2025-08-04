// Jenkinsfile
pipeline {
    // 1. Specify the macOS agent by its label
    agent { label 'macos' }

    environment {
        // Define path to Flutter SDK on the agent machine
        FLUTTER_HOME = "/Users/jenkins/flutter"
        PATH = "$FLUTTER_HOME/bin:$PATH"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clean the workspace before starting
                cleanWs()
                // Checkout code from Git
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                // Ensure Flutter is ready
                sh 'flutter clean'
                sh 'flutter pub get'
                // Install fastlane using Bundler
                dir('ios') {
                    sh 'bundle install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                sh 'flutter analyze'
                sh 'flutter test'
            }
        }

        stage('Build and Upload to App Store') {
            steps {
                // Use the Credentials Binding plugin to securely access secrets
                withCredentials([
                    file(credentialsId: 'appstore-api-key-p8', variable: 'APPSTORE_KEY_FILE'),
                    string(credentialsId: 'appstore-key-id', variable: 'APPSTORE_KEY_ID'),
                    string(credentialsId: 'appstore-issuer-id', variable: 'APPSTORE_ISSUER_ID'),
                    string(credentialsId: 'match-passphrase', variable: 'MATCH_PASSPHRASE')
                ]) {
                    // We need to Base64 encode the key file content to pass it as an environment variable
                    script {
                        // The 'sh' step with 'returnStdout: true' captures the command output
                        env.APPSTORE_KEY_CONTENT = sh(script: "base64 ${env.APPSTORE_KEY_FILE}", returnStdout: true).trim()
                    }

                    // Navigate to the iOS directory to run fastlane
                    dir('ios') {
                        sh 'bundle exec fastlane release'
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace after the build
            cleanWs()
        }
    }
}
