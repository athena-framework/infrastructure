# developer
resource "aws_iam_group" "developer" {
  name = "developer"
  path = "/"
}

resource "aws_iam_group_policy_attachments_exclusive" "developer" {
  group_name  = aws_iam_group.developer.name
  policy_arns = [aws_iam_policy.developer.arn]
}

resource "aws_iam_group_membership" "developers" {
  name  = "developers"
  group = aws_iam_group.developer.name

  users = [
    aws_iam_user.admin.name,
    aws_iam_user.athena_terraform.name,
  ]
}

# terraform
resource "aws_iam_group" "terraform" {
  name = "terraform"
  path = "/"
}

resource "aws_iam_group_policy_attachments_exclusive" "terraform" {
  group_name  = aws_iam_group.terraform.name
  policy_arns = [aws_iam_policy.terraformers.arn]
}

resource "aws_iam_group_membership" "terraformers" {
  name  = "terraformers"
  group = aws_iam_group.terraform.name

  users = [
    aws_iam_user.admin.name,
    aws_iam_user.athena_terraform.name,
  ]
}
