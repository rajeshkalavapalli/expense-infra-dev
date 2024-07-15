pipeline{
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 15, unit: 'MINUTES') 
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    stages{
        stage('list') {
            steps{
                sh """
                ls -ltr
                """
            }
        }
        stage('init') {
            steps{
               sh"""
                cd 01-vpc
                terraform init -upgrade      
                     
               """
            }
        }
        stage('plan') {
            steps{
                sh"""
                cd 01-vpc
                terraform plan       
                """
            }
        }
        stage('apply') {
             input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            steps{
                sh"""
                    cd 01-vpc
                    tarraform apply -auto-approve
                    
                """
            }
        }
        
    }
    post{
        always{
            echo "when pipline useing "
            deleteDir()
        }
         success{
            echo "when pipeline sucess"
        }
         failure{
            echo "when pipeline faild "
        }
    }
    
    
}


