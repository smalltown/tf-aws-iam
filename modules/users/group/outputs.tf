output "names" {
  value = aws_iam_group.main.*.name
}