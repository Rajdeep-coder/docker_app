pipeline {
  agent any

  options {
    skipDefaultCheckout(true)
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build and Start Containers') {
      steps {
        sh 'docker-compose build'
        sh 'docker-compose up -d'
      }
    }

    stage('Stop Containers') {
      steps {
        sh 'docker-compose down'
      }
    }
  }

  post {
    always {
      echo 'Cleaning up containers...'
      sh 'docker-compose down || true'
    }
  }
}
