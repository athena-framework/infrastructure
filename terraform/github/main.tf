resource "github_repository" "infrastructure" {
  name                        = "infrastructure"
  description                 = "Internal Athena infra configs"
  visibility                  = "public"
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  has_issues                  = false
  is_template                 = false
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  delete_branch_on_merge      = true
  auto_init                   = true
  allow_update_branch         = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_membership" "ci" {
  username = "PallasAthenaie"
  role     = "member"
}

resource "github_team" "ci" {
  name        = "CI"
  description = "Machine users that power Athena's CI"
  privacy     = "secret"
}

resource "github_team_members" "ci" {
  team_id = github_team.ci.id

  members {
    username = github_membership.ci.username
    role     = "member"
  }
}

# Athena monorepo

resource "github_repository" "athena" {
  name                        = "athena"
  description                 = "An ecosystem of reusable, independent components"
  visibility                  = "public"
  homepage_url                = "https://athenaframework.org"
  topics                      = ["api", "crystal", "framework"]
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  has_issues                  = true
  is_template                 = false
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  delete_branch_on_merge      = true
  auto_init                   = false
  allow_update_branch         = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "athena" {
  pattern       = "master"
  repository_id = github_repository.athena.node_id

  enforce_admins          = true
  required_linear_history = true
  blocks_creations        = false

  required_status_checks {
    strict = true
    contexts = [
      "coding_standards",
      "check_format",
      "test (macos-latest, latest)",
      "test (ubuntu-latest, latest)"
    ]
  }

  required_pull_request_reviews {
    required_approving_review_count = 0
  }
}

resource "github_branch" "athena" {
  branch     = "master"
  repository = github_repository.athena.id
}

resource "github_branch_default" "athena" {
  branch     = github_branch.athena.branch
  repository = github_repository.athena.id
}

resource "github_team_repository" "athena" {
  repository = github_repository.athena.id
  team_id    = github_team.ci.id
  permission = "triage"
}
