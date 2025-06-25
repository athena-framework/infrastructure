data "aws_iam_policy_document" "terraform_backend" {
  version = "2012-10-17"

  statement {
    principals {
      type = "AWS"
      identifiers = [
        data.aws_caller_identity.current.id
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalType"

      values = [
        "User"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/Terraformer"

      values = [
        "*"
      ]
    }
  }
}

resource "aws_iam_role" "terraform_backend" {
  name               = "terraform_backend"
  path               = "/terraform/"
  assume_role_policy = data.aws_iam_policy_document.terraform_backend.json
}

resource "aws_iam_role_policy_attachments_exclusive" "terraform_backend" {
  role_name = aws_iam_role.terraform_backend.name
  policy_arns = [
    aws_iam_policy.terraform_state_read_write.arn
  ]
}
