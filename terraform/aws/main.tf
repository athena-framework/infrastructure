# User
resource "aws_iam_user" "athena-terraform" {
  name = "athena-terraform"
  path = "/"
}

resource "aws_iam_user_policy_attachment" "athena-terraform" {
  user       = aws_iam_user.athena-terraform.name
  policy_arn = aws_iam_policy.athena-terraform.arn
}

resource "aws_iam_policy" "athena-terraform" {
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
                "dynamodb:PutItem",
                "dynamodb:DescribeTable",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::athena-framework",
                "arn:aws:dynamodb:*:*:table/terraform-state"
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

resource "aws_s3_bucket" "athena-framework" {
  bucket = "athena-framework"
}

resource "aws_s3_bucket_versioning" "athena-framework" {
  bucket = aws_s3_bucket.athena-framework.id

  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB

resource "aws_dynamodb_table" "terraform-state" {
  name = "terraform-state"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
