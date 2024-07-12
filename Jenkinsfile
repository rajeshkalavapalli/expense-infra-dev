pipeline{
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 15, unit: 'MINUTES') 
        disableConcurrentBuilds()
    }
    parameters {
    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')

    text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

    booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

    choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

    password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }
    stages{
        stage('build') {
            steps{
                sh 'echo this is build'
            }
        }
        stage('test') {
            steps{
                sh 'echo this is test'
                // sh 'sleep 10'
            }
        }
        stage('deploye') {
            steps{
                sh 'echo this is deploye'
            }
        }
        stage('params'){
            steps {
                echo "Hello ${params.PERSON}"
                echo "Biography: ${params.BIOGRAPHY}"
                echo "Toggle: ${params.TOGGLE}"
                echo "Choice: ${params.CHOICE}"
                // echo "Password: ${params.PASSWORD}"

            }

        }
        
    }
    post{
        always{
            echo "learning jenkins"
        }
         success{
            echo "when pipeline sucess learning jenkins"
        }
         failure{
            echo "when pipeline faild learning jenkins"
        }
    }
    
    
}
