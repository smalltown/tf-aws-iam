variable "aws_region" {
  type = "string"
}

variable "robot_account_name" {
  type        = "string"
  description = "name for robot"
}

variable "human_accounts" {
  type        = "list"
  description = "create account for human"
}

variable "read_group_name" {
  type    = "string"
}

variable "write_group_name" {
  type    = "string"
}

variable "robot_group_name" {
  type    = "string"
}

variable "account_id_mapping" {
  type        = "map"
  description = "aws account alias and id"
}