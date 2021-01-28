properties([  parameters([
  credentials (credentialType: 'com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl', defaultValue: '', description: '', name: 'CREDENTIALS', required: false), choice (choices: ['us-east-1', 'us-west-2 ', 'eu-west-1'], description: 'Please Choose your Region', name: 'REGION'),
  string (defaultValue: '', description: 'Please Type DB Instace Type', name: 'instance_type', trim: false),
  string (defaultValue: '', description: 'Please type DataBase Name', name: 'DB_Name', trim: false),
  string (defaultValue: '', description: 'Please type DataBase SubNet', name: 'subnet', trim: false),
  string (defaultValue: '', description: 'Please type DataBase Snapshot Identifier', name: 'snapshot_identifier', trim: false),
  string (defaultValue: '', description: 'Please type DataBase Security Groups', name: 'db_SG', trim: false),
  string (defaultValue: '', description: 'Please type Size of Storage', name: 'allocated_storage', trim: false),
	string (defaultValue: '', description: 'Please type Size of DB Name', name: 'DB1_Name', trim: false)
  
  
  
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
			  terraform plan -var "REGION=$REGION" -var "ACCESS_KEY=$ACCESS_KEY" -var "SECRET_KEY=$SECRET_KEY"  -var "instance_type=$instance_type" -var "DB_Name=$DB_Name" -var "subnet=$subnet" -var "snapshot_identifier=$snapshot_identifier" -var "db_SG=$db_SG" -var "allocated_storage=$allocated_storage" -var "DB1_Name=$DB1_Name"'''
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
			  terraform apply --auto-approve -var "REGION=$REGION" -var "ACCESS_KEY=$ACCESS_KEY" -var "SECRET_KEY=$SECRET_KEY"  -var "instance_type=$instance_type" -var "DB_Name=$DB_Name" -var "subnet=$subnet" -var "snapshot_identifier=$snapshot_identifier" -var "db_SG=$db_SG" -var "allocated_storage=$allocated_storage" -var "DB1_Name=$DB1_Name"'''
                }
           }
        }
         stage('Print_the_DB_Value') {
            steps {
    		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
			  accessKeyVariable: 'ACCESS_KEY', 
			  credentialsId: CREDENTIALS, 
			  secretKeyVariable: 'SECRET_KEY']]) {
			  sh '''
              
              export AWS_ACCESS_KEY_ID=$ACCESS_KEY
			  export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
			  aws rds describe-db-instances --db-instance-identifier=$DB_Name --region=$REGION | grep -i address |awk -F " " {'print $2'}
			  aws rds describe-db-instances --db-instance-identifier=$DB_Name --region=$REGION | grep  -i DBName |awk -F " " {'print $2'}'''
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
