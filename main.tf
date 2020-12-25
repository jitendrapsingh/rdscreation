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
##Added the selection & IAM Role Parameter.

resource "aws_iam_role" "IAM_Role" {
  name               = var.IAM_Role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "IAM_ROle" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.IAM_Role.name
}



resource "aws_backup_selection" "selection1" {
  iam_role_arn = aws_iam_role.IAM_Role.arn
  name         = "Resource"
  plan_id      = aws_backup_plan.plan1.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Name"
    value = "var.Tag_Name"
  }
}

##Added the Output Sections
output "Backup_Plan_Name" {
  value = "${aws_backup_plan.plan1.name}"
}

output "Vault_name" {
 value = "${aws_backup_vault.testvault.name}"
 }
output "IAM_Role_Name" {
 value = "${aws_iam_role.IAM_Role.name}"
 }
