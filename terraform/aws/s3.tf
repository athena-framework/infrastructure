
resource "aws_s3_bucket" "athena_framework" {
  bucket = "athena-framework"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "athena_framework" {
  bucket = aws_s3_bucket.athena_framework.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "athena_framework" {
  bucket = aws_s3_bucket.athena_framework.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_versioning" "athena_framework" {
  bucket = aws_s3_bucket.athena_framework.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "athena_framework_bucket" {
  version = "2012-10-17"

  statement {
    sid    = "AllowTLSRequestsOnly"
    effect = "Deny"

    actions = [
      "*"
    ]

    resources = [
      aws_s3_bucket.athena_framework.arn,
      "${aws_s3_bucket.athena_framework.arn}/*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        false
      ]
    }
  }

  # User Permissions

  # If principal is an IAM user and that user does not have the Terraformer tag, deny everything
  statement {
    sid    = "DenyNonTerraformerUsers"
    effect = "Deny"

    actions = [
      "*"
    ]

    resources = [
      aws_s3_bucket.athena_framework.arn,
      "${aws_s3_bucket.athena_framework.arn}/*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalType"

      values = [
        "User"
      ]
    }

    condition {
      test     = "StringNotLike"
      variable = "aws:PrincipalTag/Terraformer"

      values = [
        "*"
      ]
    }
  }

  # If principal is an IAM user and that user has the Terraformer tag,
  # but the tag value is not set to `Admin`, limit to read/write access
  #
  # By extension, if the user has the Terraformer tag set to Admin,
  # this policy places no restriction, granting that user whatever access is specified in their IAM user policy.
  statement {
    sid    = "RestrictTerraformNonAdmins"
    effect = "Deny"

    # Granting DeleteObject is safe because we have versioning enabled
    # on the bucket. DeleteObjectVersion is what we have to restrict
    # so that someone can't delete the delete marker and thereby
    # permanently delete state. Granting DeleteObject is helpful
    # because it allows NonAdmins to migrate state (i.e., rename state
    # files)
    not_actions = [
      "s3:List*",
      "s3:Get*",
      "s3:Describe*",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      aws_s3_bucket.athena_framework.arn,
      "${aws_s3_bucket.athena_framework.arn}/*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

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

    condition {
      test     = "StringNotEquals"
      variable = "aws:PrincipalTag/Terraformer"

      values = [
        "Admin"
      ]
    }
  }

  # Role Permissions

  # https://aws.amazon.com/blogs/security/how-to-restrict-amazon-s3-bucket-access-to-a-specific-iam-role/
  # If the principal is an assumed IAM role and that role is not the backend role, deny access.
  statement {
    sid    = "DenyNonBackendRoles"
    effect = "Deny"

    actions = [
      "*"
    ]

    resources = [
      aws_s3_bucket.athena_framework.arn,
      "${aws_s3_bucket.athena_framework.arn}/*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalType"

      values = [
        "AssumedRole"
      ]
    }

    condition {
      test     = "StringNotLike"
      variable = "aws:userId"

      values = [
        "${aws_iam_role.terraform_backend.unique_id}:*"
      ]
    }
  }

  # Default deny

  # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html#principaltable
  statement {
    sid    = "DenyAllOtherPrincipals"
    effect = "Deny"

    actions = [
      "*",
    ]

    resources = [
      aws_s3_bucket.athena_framework.arn,
      "${aws_s3_bucket.athena_framework.arn}/*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:PrincipalType"

      values = [
        "AssumedRole",
        "Account",
        "User"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "athena_framework" {
  bucket = aws_s3_bucket.athena_framework.id
  policy = data.aws_iam_policy_document.athena_framework_bucket.json
}
