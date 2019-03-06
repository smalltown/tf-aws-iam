terraform {
  required_version = ">= 0.11.11"
}

module "iam_users" {
  source = "../../modules//users"

  aws_region         = "${var.aws_region}"
  robot_account_name = "${var.robot_account_name}"
  human_accounts     = "${var.human_accounts}"
  read_group_name    = "${var.read_group_name}"
  write_group_name   = "${var.write_group_name}"
  robot_group_name    = "${var.robot_group_name}"
  account_id_mapping = "${var.account_id_mapping}"
}