variable "REGION" {}
variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}
#variable "topic_name" {}
variable "instance_type" {}
variable "DB_Name" {}
#variable "license_model" {}
variable "subnet" {}
variable "snapshot_identifier" {}
variable "db_SG" {}
variable "size" {}




provider "aws" {
  region     = var.REGION
  access_key = var.ACCESS_KEY
  secret_key = var.SECRET_KEY
  }
