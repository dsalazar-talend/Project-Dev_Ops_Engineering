pipeline {
  agent any
  stages {
    stage('Lint') {
      parallel {
        stage('Lint Front End') {
          steps {
            dir(path: 'src/front-end') {
              sh '''npm i
npm run app-lint
npm run docker-lint'''
            }

          }
        }

        stage('Lint Reverse Proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh '''npm i
npm run nginx-lint
npm run docker-lint'''
            }

          }
        }

        stage('Lint RestAPI Feed') {
          steps {
            dir(path: 'src/restapi-feed') {
              sh '''npm i
npm run app-lint
npm run docker-lint'''
            }

          }
        }

        stage('Lint RestAPI User') {
          steps {
            dir(path: 'src/restapi-user') {
              sh '''npm i
npm run app-lint
npm run docker-lint'''
            }

          }
        }

      }
    }

    stage('Build') {
      parallel {
        stage('Build Front End') {
          steps {
            dir(path: 'src/front-end') {
              sh 'sudo ./build_docker.sh'
            }

          }
        }

        stage('Build Reverse Proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh 'sudo ./build_docker.sh'
            }

          }
        }

        stage('Build RestAPI Feed') {
          steps {
            dir(path: 'src/restapi-feed') {
              sh 'sudo ./build_docker.sh'
            }

          }
        }

        stage('Build RestAPI User') {
          steps {
            dir(path: 'src/restapi-user') {
              sh 'sudo ./build_docker.sh'
            }

          }
        }

      }
    }

    stage('Launch') {
      parallel {
        stage('Launch Front End') {
          steps {
            dir(path: 'src/front-end') {
              sh 'sudo ./run_docker'
            }

          }
        }

        stage('Launch Reverse Proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh 'sudo ./run_docker'
            }

          }
        }

        stage('Launch RestAPI Feed') {
          steps {
            dir(path: 'src/restapi-feed') {
              sh 'sudo ./run_docker'
            }

          }
        }

        stage('Launch RestAPI User') {
          steps {
            dir(path: 'src/restapi-user') {
              sh 'sudo ./run_docker'
            }

          }
        }

        stage('Launch All') {
          steps {
            dir(path: 'src') {
              sh 'sudo docker-compose up'
            }

          }
        }

      }
    }

    stage('Test') {
      parallel {
        stage('Test Front End') {
          steps {
            echo 'Test User'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test Reverse Proxy') {
          steps {
            echo 'Test Front End'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test RestAPI Feed') {
          steps {
            echo 'Test Reverse Proxy'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test RestAPI User') {
          steps {
            echo 'Test Docker'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

      }
    }

    stage('Deploy') {
      parallel {
        stage('Deploy Front End') {
          steps {
            dir(path: 'src/front-end') {
              sh 'sudo ./upload_docker'
            }

          }
        }

        stage('Deploy Reverse Proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh 'sudo ./upload_docker'
            }

          }
        }

        stage('Deploy RestAPI Feed') {
          steps {
            dir(path: 'src/restapi-feed') {
              sh 'sudo ./upload_docker'
            }

          }
        }

        stage('Deploy RestAPI User') {
          steps {
            dir(path: 'src/restapi-user') {
              sh 'sudo ./upload_docker'
            }

          }
        }

      }
    }

  }
}