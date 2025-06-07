pipeline {
  agent any

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
}
