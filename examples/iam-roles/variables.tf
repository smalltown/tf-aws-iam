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
  type    = "string"
}

variable "central_account_id" {
  type    = "string"
}

variable "account_alias" {
  type = "string"

}

variable "MFAge" {
  type = "string"
}

variable "read_account_name" {
  type    = "string"
  default = "read"
}

variable "write_account_name" {
  type    = "string"
  default = "write"
}

variable "robot_account_name" {
  type    = "string"
  default = "robot"
}

variable "read_policy_actions" {
  type    = "list"
}

variable "read_policy_resources" {
  type    = "list"
}

variable "write_policy_actions" {
  type    = "list"
}

variable "write_policy_resources" {
  type    = "list"
}