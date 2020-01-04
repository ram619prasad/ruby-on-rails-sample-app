pipeline {
    agent {
        docker 'ruby:2.3.8'
    }

    stages {
        stage('Initial Setup') {
            steps {
               sh label: 'Setting up rails test environment', script: 'export RAILS_ENV=test'
               sh label: 'Installing bundler gem', script: 'gem install bundler'
            //    sh label: '', script: 'export SPRING_SERVER_COMMAND=spring server'
            }
        }
        stage('Install gems') {
            steps {
                sh label: 'Installing gems', script: 'bundle install --without development production'
                // sh label: 'uninstalling spring gem', script: 'gem uninstall spring -x -I -q'
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
