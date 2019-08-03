output "robot_group_names" {
  value = module.iam_users.robot_group_names
}

output "read_group_names" {
  value = module.iam_users.read_group_names
}

output "write_group_names" {
  value = module.iam_users.write_group_names
}

output "account_id_mapping" {
  value = var.account_id_mapping
}
