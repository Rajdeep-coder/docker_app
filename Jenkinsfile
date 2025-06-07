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

    stage('Run Tests') {
      steps {
        // Optional: Run tests here, if you have any
        // sh 'docker-compose exec app bundle exec rspec'
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
