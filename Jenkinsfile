pipeline {
  agent any

  options {
    skipDefaultCheckout(true)
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/Rajdeep-coder/docker_app.git'
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
      node {
        echo 'Cleaning up containers...'
        sh 'docker-compose down || true'
      }
    }
  }
}
