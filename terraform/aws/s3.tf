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
}

resource "aws_s3_bucket_policy" "athena_framework" {
  bucket = aws_s3_bucket.athena_framework.id
  policy = data.aws_iam_policy_document.athena_framework_bucket.json
}
