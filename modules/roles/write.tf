data "aws_iam_policy_document" "write" {
  statement {
    actions   = "${var.write_policy_actions}"
    resources = "${var.write_policy_resources}"
  }
}

resource "aws_iam_policy" "write" {
  name   =  "${var.write_account_name}"
  policy = "${data.aws_iam_policy_document.write.json}"
}

data "aws_iam_policy_document" "write_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.central_account_id}:root"]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = ["${var.MFAge}"]
    }
  }
}

resource "aws_iam_role" "write" {
  name               = "${var.write_account_name}"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.write_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "write" {
  role       = "${aws_iam_role.write.name}"
  policy_arn = "${aws_iam_policy.write.arn}"
}