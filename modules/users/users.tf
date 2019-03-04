resource "aws_iam_user" "human_accounts" {
  count = "${length(var.human_accounts)}"
  name  = "${var.human_accounts[count.index]}"
}

data "aws_iam_policy_document" "human_accounts" {

  statement {
    sid = "AllowAllUsersToListAccounts"

    actions = [
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:GetAccountSummary"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"

    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:GetAccountPasswordPolicy",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:ListSigningCertificates",
      "iam:DeleteSigningCertificate",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:DeleteSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowIndividualUserToListOnlyTheirOwnMFA"

    actions = [
      "iam:ListVirtualMFADevices",
      "iam:ListMFADevices"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowIndividualUserToManageTheirOwnMFA"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:RequestSmsMfaRegistration",
      "iam:FinalizeSmsMfaRegistration",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/$${aws:username}",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"

    actions = [
      "iam:DeactivateMFADevice"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/$${aws:username}",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}"
    ]

    condition {
      test = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values = ["true"]
    }
  }

  statement {
    sid = "BlockAnyAccessOtherThanAboveUnlessSignedInWithMFA"

    effect = "Deny"

    not_actions = [
      "iam:*"
    ]

    resources = [
      "*"
    ]

    condition {
      test = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values = ["false"]
    }
  }

}

resource "aws_iam_policy" "human_accounts" {
  count = "${length(var.human_accounts)}"

  name        = "IAMPermission"
  description = "policy for ${var.human_accounts[count.index]} basic iam permission"
  policy      = "${data.aws_iam_policy_document.human_accounts.json}"
}

resource "aws_iam_user_policy_attachment" "human_accounts" {
  count = "${length(var.human_accounts)}"

  user       = "${var.human_accounts[count.index]}"
  policy_arn = "${aws_iam_policy.human_accounts.*.arn[count.index]}"
}
