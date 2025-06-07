pipeline {
  agent any

  options {
    skipDefaultCheckout(true)
  }

  stages {
    stage('Checkout') {
      steps {
        dir('src') {
          checkout scm
        }
      }
    }

    stage('Build and Start Containers') {
      steps {
        dir('src') {
          sh 'docker-compose build'
          sh 'docker-compose up -d'
        }
      }
    }

    stage('Run Specs') {
      steps {
        dir('src') {
          // Ensure services like DB and Redis are up
          sh 'docker-compose up -d db redis'

          // Run rspec in app container
          sh 'docker-compose run --rm app bundle exec rspec'

          // Optionally: show logs if needed
          // sh 'docker-compose logs app'
        }
      }
    }

    stage('Stop Containers') {
      steps {
        dir('src') {
          sh 'docker-compose down'
        }
      }
    }
  }

  post {
    always {
      echo 'Cleaning up containers...'
      dir('src') {
        sh 'docker-compose down || true'
      }
    }
  }
}
