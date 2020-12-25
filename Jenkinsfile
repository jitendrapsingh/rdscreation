properties([  parameters([
  credentials (credentialType: 'com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl', defaultValue: '', description: '', name: 'CREDENTIALS', required: false), choice (choices: ['us-east-1', 'us-west-2 ', 'eu-west-1'], description: 'Please Choose your Region', name: 'REGION'),
  string (defaultValue: '', description: '', name: 'Plan_Name', trim: false),
  string (defaultValue: '', description: '', name: 'VAULT_NAME', trim: false),
  string (defaultValue: '', description: '', name: 'Rule_Name', trim: false),
  string (defaultValue: '', description: '', name: 'IAM_Role', trim: false),
 string (defaultValue: '', description: '', name: 'selection_tag', trim: false)
  
  
   ])
])
pipeline {
    agent any

  stages {
        stage('git checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/jitendrapsingh/pipeline1jenkinsfile'
            }
        }
        stage('terrafrom  init'){
            steps{
                sh '''
                PATH=/usr/local/bin
                terraform init'''
            }
        }
        stage('terraform plan') {
            steps {
    		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
			  accessKeyVariable: 'ACCESS_KEY', 
			  credentialsId: CREDENTIALS, 
			  secretKeyVariable: 'SECRET_KEY']]) {
			  sh '''
			  PATH=/usr/local/bin
			  terraform plan -var "REGION=$REGION" -var "ACCESS_KEY=$ACCESS_KEY" -var "SECRET_KEY=$SECRET_KEY" -var "Plan_Name=$Plan_Name" -var "VAULT_NAME=$VAULT_NAME" -var "Rule_Name=$Rule_Name" -var "IAM_Role=$IAM_Role" -var "selection_tag=$selection_tag"'''
                }
           }
        }  
        stage('terraform apply/destroy') {
            steps {
    		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
			  accessKeyVariable: 'ACCESS_KEY', 
			  credentialsId: CREDENTIALS, 
			  secretKeyVariable: 'SECRET_KEY']]) {
			  sh '''
			  PATH=/usr/local/bin
			  terraform apply --auto-approve  -var "REGION=$REGION" -var "ACCESS_KEY=$ACCESS_KEY" -var "SECRET_KEY=$SECRET_KEY" -var "Plan_Name=$Plan_Name" -var "VAULT_NAME=$VAULT_NAME" -var "Rule_Name=$Rule_Name" -var "IAM_Role=$IAM_Role" -var "selection_tag=$selection_tag"'''
                }
           }
        } 		
    }
	post { 
        always { 
            cleanWs()
        }
    }
}
