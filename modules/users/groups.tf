module "robot_groups" {
  source = "./group"
  group_name = var.robot_group_name
  account_id_mapping = var.account_id_mapping
}

module "write_groups" {
  source = "./group"
  group_name = var.write_group_name
  account_id_mapping = var.account_id_mapping
}

module "read_groups" {
  source = "./group"
  group_name = var.read_group_name
  account_id_mapping = var.account_id_mapping
}