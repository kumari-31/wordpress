pipeline {
    
    agent any
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}
    }
    
    stages {
        
        stage('Checkout'){
           steps {

                 checkout SCM                
           }
        }
        
        stage('Build Docker'){
            steps{
                script{
                    sh '''
                        echo 'Buid Docker Image'
                        docker build -t kumari3123/wordpress:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
            steps{
                script{
					withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'REGISTRY_CREDENTIALS_PSW', usernameVariable: 'REGISTRY_CREDENTIALS_USR')]) {
                        sh '''
                            echo 'Push to Repo'
                            echo "$REGISTRY_CREDENTIALS_PSW" | docker login -u "$REGISTRY_CREDENTIALS_USR" --password-stdin
                            docker push kumari3123/wordpress:${BUILD_NUMBER}
                        '''
					}
                }
            }
        }
        
        stage('Checkout K8S manifest SCM(wordpress1)'){
            steps {
                git credentialsId: 'wordpress-password', 
                    url: 'https://github.com/kumari-31/wordpress1.git',
                    branch: 'main'
            }
        }
        
        stage('Update K8S manifest & push to Repo(wordpress1)'){
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: 'wordpress-password', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                            git config user.email "skumari@cdac.in"
                            git config user.name "kumari-31"
                            cat files/deploy.yaml
                            sed -i "s/\\(kumari3123\\/wordpress:\\)[0-9]\\+/\\1${BUILD_NUMBER}/g" files/deploy.yaml
                            cat files/deploy.yaml
                            git add files/deploy.yaml
                            git commit -m 'Updated the deploy yaml | Pipeline'
                            git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/kumari-31/wordpress1.git
                            git push origin HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}
