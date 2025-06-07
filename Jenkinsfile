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
          // Remove CRLFs and ensure the script is executable
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
          sh 'docker-compose build'
          sh 'docker-compose up -d'
        }
      }
    }

    stage('Run Specs') {
      steps {
        dir('src') {
          sh '''
            echo "PWD: $PWD"
            docker-compose run --rm app bundle exec rspec
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
