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
                terraform init -reconfigure           
               """
            }
        }
        stage('plan') {
            steps{
                sh"""
                    cd 01-vpc
                    tarraform plan 
                    
                """
            }
        }
        stage('apply') {
            steps{
                 input {
                message "Should we continue?"
                ok "Yes, we should."
                
            }
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

