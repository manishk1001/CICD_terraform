pipeline{
    agent {
  label 'remote'
}
 environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-credentials')
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials')
    }

    stages{
        stage('git checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/manishk1001/terraform_lab.git'
            }
        }
        stage('init'){
            steps{
                sh 'terraform init'
            }
        }
        stage('plan'){
            steps{
                sh 'terraform plan'
            }
        }
        stage('apply'){
            steps{
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

