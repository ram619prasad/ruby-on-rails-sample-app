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
    }  
}
