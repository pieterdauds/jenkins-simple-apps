pipeline {
    environment {
        REGISTRY = "http://registry:5000"
        REGISTRYCREDENTIAL = 'registry'
        APPNAME = 'hello'
        DOCKERIMAGE = ''
        
    }
    
    agent any
    
    stages {
        stage ('Cloning GIt') {
            steps {
                git branch: 'main',
                  url: 'https://github.com/pieterdauds/jenkins-simple-apps.git'
            }
        }
        stage ('Building Image') {
            steps{
                script {
                    DOCKERIMAGE = docker.build APPNAME + ":$BUILD_NUMBER"
                }
            }
        }
        stage ('Deploy Image') {
            steps {
                script {
                    docker.withRegistry( REGISTRY, REGISTRYCREDENTIAL ) {
                        DOCKERIMAGE.push()
                    }
                }
            }
        }
        stage ('Deploy Dev?') {
            steps {
                input message: 'Approve for deploy to Dev Env?'
                sh "docker run -itd --name dev -p 80:80 registry:5000/$APPNAME:$BUILD_NUMBER"
            }
        }
        stage ('Deploy UAT?') {
            steps {
                input message: 'Approve for deploy to UAT Env?'
                sh "docker stop dev"
                sh "docker rm dev"
                sh "docker run -itd --name uat -p 80:80 registry:5000/$APPNAME:$BUILD_NUMBER"
            }
        }
        stage ('Deploy Prod?') {
            steps {
                input message: 'Approve for deploy to Prod Env?'
                sh "docker stop uat"
                sh "docker rm uat"
                sh "docker run -itd --name prod -p 80:80 registry:5000/$APPNAME:$BUILD_NUMBER"
            }
        }
    }
}
