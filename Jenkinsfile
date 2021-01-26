properties([  parameters([
  credentials (credentialType: 'com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl', defaultValue: '', description: '', name: 'CREDENTIALS', required: false), choice (choices: ['us-east-1', 'us-west-2 ', 'eu-west-1'], description: 'Please Choose your Region', name: 'REGION'),
  string (defaultValue: '', description: 'Please Type DB Instace Type', name: 'instance_type', trim: false),
  string (defaultValue: '', description: 'Please type DataBase Name', name: 'DB_Name', trim: false),
  string (defaultValue: '', description: 'Please type Private Subnet of DataBase', name: 'db-private-subnet', trim: false),
  string (defaultValue: '', description: 'Please type DataBase Snapshot Identifier', name: 'snapshot_identifier', trim: false),
  string (defaultValue: '', description: 'Please type DataBase Security Groups', name: 'db_SG"', trim: false)
  
  
  
   ])
])
pipeline {
    agent any

  stages {
        stage('git checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/jitendrapsingh/rdscreation'
                
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
			  terraform plan -var "REGION=$REGION" -var "ACCESS_KEY=$ACCESS_KEY" -var "SECRET_KEY=$SECRET_KEY"  -var "instance_type=$instance_type" -var "DB_Name=$DB_Name" -var "db-private-subnet=$db-private-subnet" -var "snapshot_identifier=$snapshot_identifier" -var "db_SG=$db_SG"'''
                }
           }
        }  
        stage('terraform apply') {
            steps {
    		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
			  accessKeyVariable: 'ACCESS_KEY', 
			  credentialsId: CREDENTIALS, 
			  secretKeyVariable: 'SECRET_KEY']]) {
			  sh '''
              set +x
              
			  PATH=/usr/local/bin
			  terraform plan -var "REGION=$REGION" -var "ACCESS_KEY=$ACCESS_KEY" -var "SECRET_KEY=$SECRET_KEY"  -var "instance_type=$instance_type" -var "DB_Name=$DB_Name" -var "db-private-subnet=$db-private-subnet" -var "snapshot_identifier=$snapshot_identifier" -var "db_SG=$db_SG"'''
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
