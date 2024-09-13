pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-php-app', '.')
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    docker.image('my-php-app').inside {
                        sh 'vendor/bin/phpunit'
                    }
                }
            }
        }
    }
}