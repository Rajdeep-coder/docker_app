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

    stage('Debug Workspace') {
      steps {
        sh 'pwd'
        sh 'ls -la'
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
          sh """
            echo "PWD: \$PWD"
            ls -l "\$PWD"
            docker-compose run --rm -v "\$PWD:/app" app sh -c "ls -l /app && bundle exec rspec"
          """
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
