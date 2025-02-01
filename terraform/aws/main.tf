# User
resource "aws_iam_user" "athena_terraform" {
  name = "athena-terraform"
  path = "/"
}

resource "aws_iam_user_policy_attachment" "athena_terraform" {
  user       = aws_iam_user.athena_terraform.name
  policy_arn = aws_iam_policy.athena_terraform.arn
}

resource "aws_iam_policy" "athena_terraform" {
  name        = "athena-terraform"
  description = "Permissions required to maintain the terraform stack once bootstrapped"
  path        = "/"

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::athena-framework"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::athena-framework/terraform/*.tfstate"
        }
    ]
}
EOT
}

# S3

resource "aws_s3_bucket" "athena_framework" {
  bucket = "athena-framework"
}

resource "aws_s3_bucket_versioning" "athena_framework" {
  bucket = aws_s3_bucket.athena_framework.id

  versioning_configuration {
    status = "Enabled"
  }
}
