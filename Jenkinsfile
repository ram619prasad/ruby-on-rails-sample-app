pipeline {
    agent {
        docker 'ram619prasad/ror_jenkins_ci:latest'
    }

    environment {
        RAILS_ENV = 'test'
        POSTGRES_USER = 'postgres'
        POSTGRES_HOST = 'database'
        // DOCKER_HOST = 'tcp://localhost:2376'
    }

    stages {
        stage('Initial Checks') {
            steps {
                sh label: 'Docker version', script: "docker --version"
                sh label: 'Docker Compose version', script: "docker-compose --version"
                sh label: 'Ruby version', script: "ruby --version"
            }
        }
        stage('DB setup for tests') {
            steps {
                sh label: '', script: 'docker ps'
                // sh label: 'Creating services', script: 'docker-compose up -d'
                sh label: 'Creating the test database', script: 'docker-compose run rails_app rails db:drop'
                sh label: 'Creating the test database', script: 'docker-compose run rails_app rails db:create'
                sh label: 'Migrating the test database', script: 'docker-compose run rails_app rails db:migrate'
            }
        }
        stage('Model tests') {
            steps {
                sh label: 'Model tests', script: 'docker-compose run rails_app rails test test/models'
            }
        }
        stage('Controller tests') {
            steps {
                sh label: 'Controllers tests', script: 'docker-compose run rails_app rails test test/controllers'
            }
        }
        stage('Mailer tests') {
            steps {
                sh label: 'Mailer tests', script: 'docker-compose run rails_app rails test test/mailers'
            }
        }
        stage('Integration tests') {
            steps {
                sh label: 'Integration tests', script: 'docker-compose run rails_app rails test test/integration'
            }
        }
        stage('Stopping all services') {
            steps {
                sh label: 'Stopping services', script: 'docker-compose down --remove-orphans'
            }
        }
    }  
}
