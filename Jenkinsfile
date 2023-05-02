pipeline {
  agent any

  tools {
      maven 'maven'
      terraform 'terraform'
        }
  stages {
     stage('checkout'){
       steps {
         echo 'checkout the code from GitRepo'
          git 'https://github.com/Srija1991/Medicure.git'
                    }
            }
    stage('Build the  Application'){
               steps {
                   echo "Cleaning.... Compiling......Testing.........Packaging"
                   sh 'mvn clean package'
                    }
                 }
     stage('publish Reports'){
               steps {
               publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Medicure/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])    
               echo "Publishing HTML reports"
	       }
            }
     stage('Docker Image Creation'){
               steps {
                      sh 'docker build -t srija1991/medicure .'
                      }
                   }

    stage('Push Image to DockerHub'){
               steps {
                   withCredentials([usernamePassword(credentialsId: 'logindocker', passwordVariable: 'docker_pswd', usernameVariable: 'docker_usr')]) {
                   sh "docker login -u ${env.docker_usr} -p ${env.docker_pswd}"
                   echo "*******************************Docker LOGIN Successful***************************************************"
                      }
                 }
            }

     stage('Push Image to docker Hub'){
        steps{
           sh 'docker push srija1991/medicure' 
                echo "*********************************************Image pushed succesfully onto DockerHUB************************************************"
      }
}
     stage ('Configure Test-server with Terraform, Ansible and then Deploying'){
            steps {
                dir('test-server'){
                sh 'chmod 600 apr26.pem'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
            }
        }
   }
}
