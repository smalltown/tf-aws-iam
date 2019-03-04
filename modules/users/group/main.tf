resource "aws_iam_group" "main" {
  count = "${length(keys(var.account_id_mapping))}"
  name  = "${element(keys(var.account_id_mapping), count.index)}-${var.group_name}"
}

data "aws_iam_policy_document" "main" {
  count = "${length(keys(var.account_id_mapping))}"

  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${element(values(var.account_id_mapping), count.index)}:role/${var.group_name}"]
  }
}

resource "aws_iam_policy" "main" {
  count  = "${length(keys(var.account_id_mapping))}"
  name   = "${element(keys(var.account_id_mapping), count.index)}-${var.group_name}"
  policy = "${element(data.aws_iam_policy_document.main.*.json, count.index)}"
}

resource "aws_iam_group_policy_attachment" "main" {
  count      = "${length(keys(var.account_id_mapping))}"
  group      = "${element(aws_iam_group.main.*.name, count.index)}"
  policy_arn = "${element(aws_iam_policy.main.*.arn, count.index)}"
}
