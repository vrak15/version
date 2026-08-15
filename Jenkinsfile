pipeline {
    agent any
    stages {
        stage('checkout'){
            steps {
                git branch: 'main', credentialsId: 'github-creds', url: 'https://github.com/vrak15/version.git'
            }
        }
        stage('Docker-image-build'){
            steps{
                sh 'docker build -t vrak45/simple-web-app .'
            }
        }
        stage('Docker-image-push'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DH_PASS', usernameVariable: 'DH_USER')]) 
                {
                    sh 'echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin'
                    sh 'docker push vrak45/simple-web-app:latest'
                    sh 'docker logout'
                }
            }
        }
        stage('Deploy container'){
            steps {
                sh 'docker stop cont1 || true'
                sh 'docker rm cont1 || true'
                sh 'docker run -d --name cont1 -p 80:80 vrak45/simple-web-app:latest'
            }
        }
    }
}
