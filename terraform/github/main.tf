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

