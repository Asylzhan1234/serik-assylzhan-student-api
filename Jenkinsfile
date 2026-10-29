pipeline {
    agent any

    tools {
        jdk 'jdk17'
    }

    environment {
        STUDENT_NAME = 'Serik Assylzhan'
        IMAGE_NAME   = 'serik-assylzhan-student-api'
        IMAGE_TAG    = 'v1.1-serik-assylzhan'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Student: ${STUDENT_NAME} - checkout from GitHub"
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Student: ${STUDENT_NAME} - building with Gradle"
                sh 'chmod +x gradlew'
                sh './gradlew clean build -x test --no-daemon'
            }
        }

        stage('Test') {
            steps {
                echo "Student: ${STUDENT_NAME} - running tests"
                sh './gradlew test --no-daemon'
            }
        }

        stage('Docker Build') {
            steps {
                echo "Student: ${STUDENT_NAME} - building image ${IMAGE_NAME}:${IMAGE_TAG}"
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    docker image inspect ${IMAGE_NAME}:${IMAGE_TAG} > /dev/null
                    echo "VERIFY OK: image ${IMAGE_NAME}:${IMAGE_TAG} exists (student: ${STUDENT_NAME})"
                    docker images ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        success {
            echo "SUCCESS: pipeline of ${STUDENT_NAME} finished"
        }
        failure {
            echo "FAILURE: pipeline of ${STUDENT_NAME} failed - see the failed stage above"
        }
    }
}
