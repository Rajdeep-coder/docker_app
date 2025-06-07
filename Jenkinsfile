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
