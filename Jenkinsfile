pipeline {
    agent {
        docker 'ram619prasad/ror_jenkins_pipeline_sample'
    }

    stages {
        stage('Initial Setup') {
            steps {
               sh label: 'Setting up rails test environment', script: 'export RAILS_ENV=test'
               sh label: '', script: 'export POSTGRES_USER=postgres'
               sh label: '', script: 'export POSTGRES_HOST=localhost'
               sh label: 'Postgres version', script: 'echo postgres --version'
            }
        }
        // stage('Install gems') {
        //     steps {
        //         sh label: 'Installing gems', script: 'bundle install --without production'
        //         // sh label: 'uninstalling spring gem', script: 'gem uninstall spring -x -I -q'
        //     }
        // }
        stage('DB setup for tests') {
            steps {
                sh label: 'Test db setup', script: 'rake db:create db:migrate'
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
