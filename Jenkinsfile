pipeline {

  agent {
    node {
      label 'docker_in_docker'
    }

  }

  environment {
    SW_VERSION = '12.2.1.9'
    SW_FILE = 'oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip'
    SW_DIR = '/software/Oracle/OEPE'
  }

  options {
    buildDiscarder(logRotator(numToKeepStr:'10'))
  }

  stages {

    stage('Build Oracle Enterprise Pack for Eclipse Image') {
      steps {
        sh '''
          export DOCKER_BUILDKIT=1
          if [ ! -f $SW_FILE ]; then cp "$SW_DIR/$SW_FILE" $SW_FILE; fi
          sh 'sudo docker build --progress=plain --tag oracle/oepe:$SW_VERSION --build-arg SW_FILE=$SW_FILE .
        '''
      }
    }

    stage('Push Docker Image to Local Registry') {
      steps {
        sh 'docker tag oracle/oepe:$SW_VERSION localhost:5000/oracle/oepe:$SW_VERSION'
        sh 'docker push localhost:5000/oracle/oepe:$SW_VERSION'
      }
    }

    stage('Cleanup') {
      steps {
        sh 'docker rmi --force localhost:5000/oracle/oepe:$SW_VERSION'
        sh 'docker rmi --force oracle/oepe:$SW_VERSION'
      }
    }

  }

}
