resource "github_repository" "website" {
  name                        = "website"
  description                 = "Website (docs) for the Athena Framework"
  visibility                  = "public"
  homepage_url                = "https://athenaframework.org/"
  topics                      = local.topics
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  has_issues                  = true
  is_template                 = false
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  delete_branch_on_merge      = true
  auto_init                   = false
  allow_update_branch         = true

  pages {
    cname = "athenaframework.org"

    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "website" {
  pattern       = "master"
  repository_id = github_repository.website.node_id

  enforce_admins          = true
  required_linear_history = true
  allows_deletions        = false
  allows_force_pushes     = false

  required_status_checks {
    strict = true
    contexts = [
      "check_spelling",
      "Deploy docs",
    ]
  }

  required_pull_request_reviews {
    required_approving_review_count = 0
  }
}

resource "github_branch" "website" {
  branch     = "master"
  repository = github_repository.website.id
}

resource "github_branch_default" "website" {
  branch     = github_branch.website.branch
  repository = github_repository.website.id
}

resource "github_team_repository" "website" {
  repository = github_repository.website.id
  team_id    = github_team.ci.id
  permission = "push"
}
