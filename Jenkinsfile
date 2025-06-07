pipeline {
  agent any

  options {
    skipDefaultCheckout(true)
  }

  environment {
    SRC_DIR = 'src'
  }

  stages {
    stage('Checkout') {
      steps {
        dir(env.SRC_DIR) {
          checkout scm
        }
      }
    }

    stage('Debug Workspace') {
      steps {
        dir(env.SRC_DIR) {
          sh 'pwd'
          sh 'ls -la'
        }
      }
    }

    stage('Build and Start Containers') {
      steps {
        dir(env.SRC_DIR) {
          sh 'docker-compose build --no-cache'
          sh 'docker-compose up -d'
          // Wait a bit for containers to settle
          sh 'sleep 5'
        }
      }
    }

    // stage('Debug Container Mount') {
    //   steps {
    //     dir(env.SRC_DIR) {
    //       sh '''
    //         echo "Listing /app inside container:"
    //         echo "Building containers..."
    //         docker-compose build
    //         echo "Running specs directly..."
    //         docker-compose run --rm app bundle exec rspec
    //       '''
    //     }
    //   }
    // }

    stage('Check App Logs') {
      steps {
        dir(env.SRC_DIR) {
          sh '''
            echo "Checking app logs (last 50 lines)..."
            docker-compose logs app | tail -n 50 || true
          '''
        }
      }
    }

    stage('Stop Containers') {
      steps {
        dir(env.SRC_DIR) {
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
