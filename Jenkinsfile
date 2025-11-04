pipeline {
    agent any // Run on any available Jenkins agent

    environment {
        // Make sure Jenkins uses the PATH where Flutter is installed
        PATH = "/opt/flutter/bin:${env.PATH}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clones the repository from the URL configured in the job
                checkout scm
            }
        }

        stage('Build & Test with Fastlane') {
            steps {
                // Navigate into the android directory to run fastlane
                dir('android') {
                    sh 'fastlane build_and_test'
                }
            }
        }

        stage('Archive Build') {
            steps {
                // Save the generated .aab file as a build artifact in Jenkins
                archiveArtifacts 'build/app/outputs/bundle/release/*.aab'
            }
        }
    }

    post {
        // This block runs after all stages complete
        always {
            echo 'Build finished.'
            cleanWs() // Clean up the workspace
        }
    }
}
