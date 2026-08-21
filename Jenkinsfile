pipeline {
    
    agent any 
    
    stages {
        stage('checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/intiquab-siddiqui/jenkins-docker-cicd-project.git'
            }
        }
        stage('Docker build') {
            steps {
                sh 'docker build -t jenkins-docker-cicd-app .'
            }
        }
        stage('docker run') {
            steps {
                sh 'docker rm -f jenkins-docker-cicd-container || true'
                sh 'docker run -d -p 5000:5000 --name jenkins-docker-cicd-container jenkins-docker-cicd-app:latest'
            }
        }
    }
}
