# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  type = "string"
}

variable "robot_account_name" {
  type    = "string"
  default = "robot"
}

variable "human_accounts" {
  type = "list"
}

variable "read_group_name" {
  type    = "string"
  default = "read"
}

variable "write_group_name" {
  type    = "string"
  default = "write"
}
variable "robot_group_name" {
  type    = "string"
  default = "robot"
}
variable "account_id_mapping" {
  type = "map"
}