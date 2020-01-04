pipeline {
    agent {
        docker 'ruby:2.3.8'
    }

    stages {
        stage('Initial Setup') {
            steps {
               sh label: 'Setting up rails test environment', script: 'export RAILS_ENV=test'
               sh label: 'Installing bundler gem', script: 'gem install bundler' 
            }
        }
        stage('Install gems') {
            steps {
                sh label: 'Installing gems', script: 'bundle install --without production'
            }
        }
        stage('Testing') {
            parallel {
                stage('Model tests') {
                    steps {
                        sh label: 'Model tests', script: 'rails test test/models'
                    }
                }
                stage('Controller tests') {
                    steps {
                        sh label: 'Controllers tests', script: 'rails test test/controllers'
                    }
                }
                stage('Mailer tests') {
                    steps {
                        sh label: 'Mailer tests', script: 'rails test test/mailers'
                    }
                }
                stage('Integration tests') {
                    steps {
                        sh label: 'Integration tests', script: 'rails test test/integraion'
                    }
                }
            }
        }
    }  
}
