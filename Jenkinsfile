pipeline{
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 15, unit: 'MINUTES') 
        disableConcurrentBuilds()
    }
    stages{
        stage('init') {
            steps{
                sh """
                ls -ltr
                """
            }
        }
        stage('plan') {
            steps{
               
            }
        }
        stage('apply') {
            steps{
                
            }
        }
        
    }
    post{
        always{
            echo "when pipline useing "
        }
         success{
            echo "when pipeline sucess"
        }
         failure{
            echo "when pipeline faild "
        }
    }
    
    
}

