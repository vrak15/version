pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/<YOUR_GITHUB_USERNAME>/version.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t <YOUR_DOCKERHUB_USERNAME>/my-web-app:latest .'
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
                    sh '''
                        echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin
                        docker push <YOUR_DOCKERHUB_USERNAME>/my-web-app:latest
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                    docker stop my-running-app || true
                    docker rm my-running-app || true
                    docker run -d --name my-running-app -p 80:80 <YOUR_DOCKERHUB_USERNAME>/my-web-app:latest
                '''
            }
        }
    }
}
