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
          sh '''
            echo "Starting containers..."
            docker-compose up -d db redis app

            echo "Current container status:"
            docker-compose ps

            CONTAINER=$(docker-compose ps -q app)
            echo "App container ID: $CONTAINER"

            echo "App container logs:"
            docker logs $CONTAINER || true

            STATUS=$(docker inspect -f '{{.State.Running}}' $CONTAINER)
            echo "Is app container running? $STATUS"

            if [ "$STATUS" = "true" ]; then
              echo "Running specs inside the app container..."
              docker exec $CONTAINER bundle exec rspec
            else
              echo "App container is not running, skipping specs run."
              exit 1
            fi

            echo "Stopping containers..."
            docker-compose down
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
