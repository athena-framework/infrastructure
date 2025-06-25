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
      "${aws_s3_bucket.athena_framework.arn}/terraform/*.tfstate.tflock"
    ]
  }
}

resource "aws_iam_policy" "terraform_state_read_write" {
  name        = "terraform_state_read_write"
  path        = "/terraform/"
  description = "Read/write access to terraform state"
  policy      = data.aws_iam_policy_document.terraform_state_read_write.json
}

# Developers have permission to assume roles.
data "aws_iam_policy_document" "developer" {
  version = "2012-10-17"

  statement {
    sid    = "AllowAssumingRoles"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      aws_iam_role.terraform_backend.arn
    ]
  }
}

resource "aws_iam_policy" "developer" {
  name        = "developer"
  path        = "/"
  description = "Common developer permissions"
  policy      = data.aws_iam_policy_document.developer.json
}

# Terraformers have access to only S3 and IAM as that's all we use.
data "aws_iam_policy_document" "terraformers" {
  version = "2012-10-17"

  statement {
    sid    = "S3Permissions"
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid    = "IAMPermissions"
    effect = "Allow"

    actions = [
      "iam:*",
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "terraformers" {
  name        = "terraformer"
  path        = "/terraform/"
  description = "AWS Terraform permissions"
  policy      = data.aws_iam_policy_document.terraformers.json
}
