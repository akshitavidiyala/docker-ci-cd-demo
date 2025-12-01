pipeline {
    agent any

    environment {
        // 👇 put your real Docker Hub repo here
        // example: "akshitavidiyala/docker-ci-cd-demo"
        DOCKERHUB_REPO = "akshitavidiyala/docker-ci-cd-demo"
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
                    def imageTag = "${env.BUILD_NUMBER}"
                    sh """
                        echo "Building image ${DOCKERHUB_REPO}:${imageTag} ..."
                        docker build -t ${DOCKERHUB_REPO}:${imageTag} -t ${DOCKERHUB_REPO}:latest .
                    """
                }
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                script {
                    withCredentials([
                        usernamePassword(
                            credentialsId: 'dockerhub-creds',
                            usernameVariable: 'DOCKER_USER',
                            passwordVariable: 'DOCKER_PASS'
                        )
                    ]) {
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

