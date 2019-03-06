terraform {
  required_version = ">= 0.11.11"
}

module "iam_roles" {
  source = "../../modules//roles"

  aws_region             = "${var.aws_region}"
  central_account_id     = "${var.central_account_id}"
  account_alias          = "${var.account_alias}"
  MFAge                  = "${var.MFAge}"
  read_account_name      = "${var.read_account_name}"
  write_account_name     = "${var.write_account_name}"
  robot_account_name     = "${var.robot_account_name}"
  read_policy_actions    = "${var.read_policy_actions}"
  read_policy_resources  = "${var.read_policy_resources}"
  write_policy_actions   = "${var.write_policy_actions}"
  write_policy_resources = "${var.write_policy_resources}"
}