output "read_role_name" {
  value = aws_iam_role.read.name
}

output "write_role_name" {
  value = aws_iam_role.write.name
}

output "robot_role_name" {
  value = aws_iam_role.robot.name
}