# Primary user, should be phased out into actual named user accounts if more than 1 person is on the core team.
resource "aws_iam_user" "admin" {
  name = "admin"
  path = "/"
}

resource "aws_iam_user_policy_attachment" "admin_s3" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "admin_iam" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}
