pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'akshitavidiyala'        // your Docker Hub username
        IMAGE_NAME = 'my-docker-ci-cd-app'           // your Docker Hub repo name
        FULL_IMAGE = "docker.io/${DOCKERHUB_USERNAME}/${IMAGE_NAME}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    IMAGE_TAG = "${BUILD_NUMBER}"
                    dockerImage = docker.build("${FULL_IMAGE}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        dockerImage.push()  // push version tag
                        sh "docker tag ${FULL_IMAGE}:${BUILD_NUMBER} ${FULL_IMAGE}:latest"
                        sh "docker push ${FULL_IMAGE}:latest"
                    }
                }
            }
        }
    }

    post {
        always {
            sh "docker image prune -f || true"
        }
    }
}

