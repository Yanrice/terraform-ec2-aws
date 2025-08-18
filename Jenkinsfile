pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=plan.tfout'
            }
        }
        stage('Approval') {
            when {
                branch 'main'  // Optional: only require approval on main branch
            }
            steps {
                input message: 'Do you want to apply the Terraform changes?', ok: 'Apply'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply plan.tfout'
            }
        }
    }
    post {
        always {
            deleteDir()  // Clean workspace
        }
    }
}
