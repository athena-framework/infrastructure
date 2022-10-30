terraform {
  required_providers {
    github = {
      source  = "integrations/github"
    }
  }
}

resource "github_repository" "component" {
  name                        = var.name
  description                 = var.description
  visibility                  = var.visibility
  homepage_url                = var.url
  topics                      = var.topics
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  has_issues                  = false
  is_template                 = false
  allow_auto_merge            = false
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  delete_branch_on_merge      = false
  auto_init                   = false
  allow_update_branch         = false

  template {
    owner      = "athena-framework"
    repository = "component-template"
  }
}

resource "github_branch_protection" "master" {
  repository_id = github_repository.component.node_id
  pattern       = "master"

  enforce_admins          = true
  required_linear_history = true
  allows_deletions        = false
  allows_force_pushes     = false
  blocks_creations        = true

  required_pull_request_reviews {
    required_approving_review_count = 0
    pull_request_bypassers = [
      var.ci_team.node_id
    ]
  }

  # TODO: Restrict creating matching branches
  push_restrictions = [
    var.ci_team.node_id
  ]
}

resource "github_branch" "default" {
  repository = github_repository.component.id
  branch     = var.branch
}

resource "github_branch_default" "default" {
  repository = github_repository.component.id
  branch     = var.branch
}

resource "github_team_repository" "ci" {
  repository = github_repository.component.id
  team_id    = var.ci_team.id
  permission = "push"
}
