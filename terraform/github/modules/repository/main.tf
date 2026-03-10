terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

resource "github_repository" "this" {
  name                        = var.name
  description                 = var.description
  visibility                  = var.visibility
  homepage_url                = var.url
  topics                      = concat(var.topics, [var.type])
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

  archived = var.deprecated

  dynamic "template" {
    for_each = var.historic == true ? [] : [1]
    content {
      owner      = var.organization
      repository = "${var.type}-template"
    }
  }
}

resource "github_actions_repository_permissions" "this" {
  repository = github_repository.this.id
  enabled    = false
}

resource "github_branch_protection" "master" {
  repository_id = github_repository.this.node_id
  pattern       = "master"

  enforce_admins          = true
  required_linear_history = true
  allows_deletions        = false
  allows_force_pushes     = false

  restrict_pushes {
    blocks_creations = true

    push_allowances = [
      var.ci_team.node_id
    ]
  }
}

resource "github_branch_default" "default" {
  repository = github_repository.this.id
  branch     = var.branch
}

resource "github_team_repository" "ci" {
  repository = github_repository.this.id
  team_id    = var.ci_team.id
  permission = "push"
}

# Doc branch used to build the API docs
resource "github_branch" "docs" {
  repository    = github_repository.this.id
  branch        = "docs"
  source_branch = var.branch
}

# Issue label in the monorepo
resource "github_issue_label" "this" {
  repository = "athena"
  name       = "${var.type}:${trimsuffix(var.name, "-bundle")}"
  color      = var.type == "bundle" ? "1A3C50" : "BBD8F2"
}
