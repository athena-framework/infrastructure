resource "github_actions_organization_permissions" "athena_framework" {
  sha_pinning_required = true
  enabled_repositories = "selected"
  allowed_actions      = "all"

  enabled_repositories_config {
    repository_ids = [
      github_repository.athena.repo_id,
      github_repository.demo.repo_id,
      github_repository.skeleton.repo_id,
      github_repository.infrastructure.repo_id,
    ]
  }
}

resource "github_repository" "infrastructure" {
  name                        = "infrastructure"
  description                 = "Internal Athena infra configs"
  visibility                  = "public"
  has_projects                = false
  has_wiki                    = false
  has_issues                  = false
  is_template                 = false
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
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
