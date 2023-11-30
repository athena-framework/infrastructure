resource "github_repository" "demo" {
  name                        = "demo"
  description                 = "Demo blog application using Athena Framework"
  visibility                  = "public"
  homepage_url                = "https://athenaframework.org/"
  topics                      = local.topics
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  has_issues                  = true
  is_template                 = true
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  delete_branch_on_merge      = true
  auto_init                   = true
  allow_update_branch         = true

  template {
    owner      = "athena-framework"
    repository = "skeleton"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "demo" {
  pattern       = "master"
  repository_id = github_repository.demo.node_id

  enforce_admins          = true
  required_linear_history = true
  allows_deletions        = false
  allows_force_pushes     = false

  required_status_checks {
    strict = true
    contexts = [
      "coding_standards",
      "check_format",
      "check_spelling",
      "test (ubuntu-latest, latest)"
    ]
  }

  required_pull_request_reviews {
    required_approving_review_count = 0
  }
}

resource "github_branch" "demo" {
  branch     = "master"
  repository = github_repository.demo.id
}

resource "github_branch_default" "demo" {
  branch     = github_branch.demo.branch
  repository = github_repository.demo.id
}
