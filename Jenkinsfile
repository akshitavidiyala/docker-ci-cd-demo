pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'akshitavidiyala'        // your Docker Hub username
    pipeline {
    agent any

    environment {
        // CHANGE THIS to your Docker Hub repo name
        DOCKERHUB_REPO = "akshitavidiyala/my-docker-ci-cd-app"
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
                    sh """
                        echo "Building image ${DOCKERHUB_REPO}:${IMAGE_TAG} ..."
                        docker build -t ${DOCKERHUB_REPO}:${IMAGE_TAG} -t ${DOCKERHUB_REPO}:latest .
                    """
                }
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh """
                            echo "Logging in to Docker Hub..."
                            echo "\$DOCKER_PASS" | docker login -u "\$DOCKER_USER" --password-stdin

                            echo "Pushing image tags..."
                            docker push ${DOCKERHUB_REPO}:${BUILD_NUMBER}
                            docker push ${DOCKERHUB_REPO}:latest
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker image prune -f || true'
        }
    }
}


