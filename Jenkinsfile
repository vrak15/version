pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                echo '✅ Cloning the repository...'
                // This step is automatic when using "Pipeline script from SCM"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🔨 Building Docker image from version directory...'
                sh '''
			cd version/
		docker build -t simple-web-app .
		'''
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Running Docker container...'
                sh '''
                    docker stop simple-web-app || true
                    docker rm simple-web-app || true
                    docker run -d --name simple-web-app -p 80:80 simple-web-app
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo '✅ App is running on port 80!'
                sh 'curl -s http://localhost:80 | head -n 5'
            }
        }
    }

    post {
        always {
            echo '📋 Pipeline completed!'
        }
        failure {
            echo '❌ Pipeline failed! Check the logs above.'
        }
    }
}
