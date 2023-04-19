pipeline{
    agent any
 environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-credentials')
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials')
    }

    stages{
        stage('git checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/manishk1001/terraform.git'
            }
        }
        stage('init'){
            steps{
                bat 'terraform init'
            }
        }
        stage('plan'){
            steps{
                bat 'terraform plan'
            }
        }
        stage('apply'){
            steps{
                bat 'terraform apply -auto-approve'
            }
        }
    }
}

