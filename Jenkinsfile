pipeline {
  agent {
    node {
      label 'localhost_vagrant'
    }

  }
  options {
    buildDiscarder(logRotator(numToKeepStr:'10'))
  }
  stages {
    stage('Build Oracle Enterprise Pack for Eclipse Image') {
      steps {
        sh 'if [ ! -f $SW_FILE ]; then cp "$SW_DIR/$SW_FILE" $SW_FILE; fi'
        sh 'sudo docker build --tag oracle/oepe:$SW_VERSION --build-arg SW_FILE=$SW_FILE .'
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
  environment {
    SW_VERSION = '12.2.1.5'
    SW_FILE = 'oepe-12.2.1.5-neon-distro-linux-gtk-x86_64.zip'
    SW_DIR = '/software/Oracle/Enterprise Pack for Eclipse'
  }
}
