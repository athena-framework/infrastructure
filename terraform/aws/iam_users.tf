# Primary user, should be phased out into actual named user accounts if more than 1 person is on the core team.
resource "aws_iam_user" "admin" {
  name = "admin"
  path = "/"

  tags = {
    Terraformer = "Admin"
  }
}

# User that'll be used in CI and such to handle AWS terraform interactions.
resource "aws_iam_user" "athena_terraform" {
  name          = "athena-terraform"
  path          = "/terraform/"
  force_destroy = true

  tags = {
    Terraformer = "Developer"
  }
}
