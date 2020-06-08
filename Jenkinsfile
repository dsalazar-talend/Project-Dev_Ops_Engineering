pipeline {
  // specifies where the entire Pipeline, or a specific stage, will execute
  // in the Jenkins environment depending on where the agent section is placed
  // [any, none, label, node, docker, dockerfile, kubernetes]
  agent any
  stages {
    // Stage 1: Building Docker images
    stage('Build/Launch') {
      parallel {
        stage('Build Frontend') {
          steps {
            dir(path: 'src/front-end') {
              sh 'docker build -t dsalazar10/udagram:frontend .'
            }
          }
        }
        stage('Build Feed') {
          steps {
            dir(path: 'src/restapi-feed/') {
              sh 'docker build -t dsalazar10/udagram:feed .'
            }
          }
        }
        stage('Build User') {
          steps {
            dir(path: 'src/restapi-user/') {
              sh 'docker build -t dsalazar10/udagram:user .'
            }
          }
        }
        stage('Build Reverse-proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh 'docker build -t dsalazar10/udagram:reverse-proxy .'
            }
          }
        }
      }
    }

    stage('Test') {
      parallel {
        stage('Test Feed') {
          agent { docker 'node:12' }
          steps {
            dir(path: 'src/restapi-feed/') {
              sh 'npm run test'
            }
          }
        }

        stage('Test User') {
          agent { docker 'node:12' }
          steps {
            dir(path: 'src/restapi-user/') {
              sh 'npm run test'
            }
          }
        }

        stage('Test Frontend') {
          agent { docker 'beevelop/ionic' }
          steps {
            dir(path: 'src/front-end/') {
              sh 'npm run test'
            }
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        echo 'Software is verified and ready for integration!'
        s3Upload(bucket: 'jenkinsbucket', file: 'test.txt')
      }
    }
  }
}
