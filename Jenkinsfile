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

    stage('Fix Line Endings & Permissions') {
      steps {
        dir('src') {
          // Remove CRLFs and make script executable
          sh "tr -d '\\r' < entrypoint.sh > fixed.sh && mv fixed.sh entrypoint.sh"
          sh "chmod +x entrypoint.sh"
        }
      }
    }

    stage('Debug Workspace') {
      steps {
        dir('src') {
          sh 'pwd'
          sh 'ls -la'
        }
      }
    }

    stage('Build and Start Containers') {
      steps {
        dir('src') {
          sh 'docker-compose build --no-cache'
          sh 'docker-compose up -d'
        }
      }
    }

    stage('Debug Container Mount') {
      steps {
        dir('src') {
          sh '''
            echo "Listing /app inside container:"
            docker-compose run --rm app ls -la /app
          '''
        }
      }
    }


    stage('Check App Logs') {
      steps {
        dir('src') {
          sh '''
            echo "Checking app logs (last 50 lines)..."
            docker-compose logs app | tail -n 50 || true
          '''
        }
      }
    }

    stage('Run Specs') {
      steps {
        dir('src') {
          sh '''
            echo "Running specs..."
            docker-compose run --rm -v "$PWD:/app" app bundle exec rspec
          '''
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
