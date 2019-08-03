variable "aws_region" {
  type        = string
  description = ""
}

variable "central_account_id" {
  type        = string
  description = ""
}

variable "account_alias" {
  type        = string
  description = ""
}

variable "MFAge" {
  type        = string
  description = ""
}

variable "read_account_name" {
  type        = string
  description = ""
}

variable "write_account_name" {
  type        = string
  description = ""
}

variable "robot_account_name" {
  type        = string
  description = ""
}

variable "read_policy_actions" {
  type        = list(string)
  description = ""
}

variable "read_policy_resources" {
  type        = list(string)
  description = ""
}

variable "write_policy_actions" {
  type        = list(string)
  description = ""
}

variable "write_policy_resources" {
  type        = list(string)
  description = ""
}