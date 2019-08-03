resource "aws_iam_user" "robot" {
  name  = var.robot_account_name
}

resource "aws_iam_group_membership" "robot" {
  count = length(module.robot_groups.names)

  name = var.robot_group_name
  users = [ aws_iam_user.robot.name ]
  group = module.robot_groups.names[count.index]
}
