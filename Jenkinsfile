pipeline {
    agent {
        docker 'ruby:2.3.3-alpine'
    }

    stages {
        stage('checkout') {
            steps {
                echo 'checkout stage'
            }
        }
        stage('Install gems and run migrations') {
            steps {
                echo 'installing gems and running all migrations'
            }
        }
    }  
}
