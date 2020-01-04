pipeline {
    agent {
        docker 'ruby:2.3.8'
    }

    stages {
        stage('Initial Setup') {
            steps {
               sh label: 'Setting up rails test environment', script: 'export RAILS_ENV=test'
               sh label: 'Installing bundler gem', script: 'gem install bundler'
            //    sh label: 'Installing nodejs required for runtime', script: 'apt-get install nodejs -y'
            //    sh label: '', script: 'export SPRING_SERVER_COMMAND=spring server'
            }
        }
        stage('Install gems') {
            steps {
                sh label: 'Installing gems', script: 'bundle install --without production'
                // sh label: 'uninstalling spring gem', script: 'gem uninstall spring -x -I -q'
            }
        }
        stage('Testing') {
            parallel {
                stage('Model tests') {
                    steps {
                        sh label: 'Model tests', script: 'bundle exec rails test test/models'
                    }
                }
                stage('Controller tests') {
                    steps {
                        sh label: 'Controllers tests', script: 'bundle exec rails test test/controllers'
                    }
                }
                stage('Mailer tests') {
                    steps {
                        sh label: 'Mailer tests', script: 'bundle exec rails test test/mailers'
                    }
                }
                stage('Integration tests') {
                    steps {
                        sh label: 'Integration tests', script: 'bundle exec rails test test/integraion'
                    }
                }
            }
        }
    }  
}
