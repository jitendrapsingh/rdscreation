#terraform {
#  backend "s3" {
#   bucket = "sftptestjitendra"
#    key    = "Backup_Job/tffile1"
#    region = "eu-west-1"
 #  }
#  }

resource "aws_backup_vault" "testvault" {
  name        = var.VAULT_NAME
  }


resource "aws_backup_plan" "plan1" {
  name = var.Plan_Name

  rule {
    rule_name         = var.Rule_Name
    target_vault_name = aws_backup_vault.testvault.name
    schedule          = "cron(0 23 ? 1-12 L)"
  }

}
