resource "aws_db_instance" "db_from_snapshot" {
  #region = var.REGION
  instance_class   = var.instance_type
  identifier              = var.DB_Name
  #rds_license_model    = var.license_model
  db_subnet_group_name = var.subnet
  snapshot_identifier  = var.snapshot_identifier
  vpc_security_group_ids = [ "${var.db_SG}" ]
  allocated_storage = 25
  skip_final_snapshot = false
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = false

}
