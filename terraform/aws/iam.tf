
# Users

resource "aws_iam_user" "admin" {
  name = "admin"
  path = "/"

  tags = {
    Terraformer = "Admin"
  }
}

resource "aws_iam_user" "athena_terraform" {
  name          = "athena-terraform"
  path          = "/terraform/"
  force_destroy = true

  tags = {
    Terraformer = "Developer"
  }
}

# IAM Policies

# https://developer.hashicorp.com/terraform/language/backend/s3#permissions-required
# Using `use_lockfile` so needs get, put, and delete on `*.tflock`.
data "aws_iam_policy_document" "terraform_state_read_write" {
  version = "2012-10-17"

  statement {
    sid    = "AllowStateBucketList"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketVersioning",
    ]

    resources = [
      aws_s3_bucket.athena_framework.arn
    ]
  }

  statement {
    sid    = "AllowStateReadWrite"
    effect = "Allow"

    # Intentionally not including `s3:DeleteObject` as it's not required
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.athena_framework.arn}/terraform/*.tfstate"
    ]
  }

  statement {
    sid    = "AllowStateLockReadWrite"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "${aws_s3_bucket.athena_framework.arn}/terraform/*.tflock"
    ]
  }
}

resource "aws_iam_policy" "terraform_state_read_write" {
  name        = "terraform_state_read_write"
  path        = "/terraform/"
  description = "Read/write access to terraform state"
  policy      = data.aws_iam_policy_document.terraform_state_read_write.json
}

# IAM Roles

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

resource "aws_iam_role_policy_attachment" "terraform_backend" {
  role       = aws_iam_role.terraform_backend.name
  policy_arn = aws_iam_policy.terraform_state_read_write.arn
}
