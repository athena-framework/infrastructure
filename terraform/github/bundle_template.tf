resource "github_repository" "bundle_template" {
  name                        = "bundle-template"
  description                 = "Template repository for scaffolding new Athena bundles"
  visibility                  = "public"
  topics                      = local.topics
  has_projects                = false
  has_wiki                    = false
  has_issues                  = false
  is_template                 = true
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  delete_branch_on_merge      = true
  auto_init                   = false
  allow_update_branch         = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "bundle_template" {
  pattern       = "master"
  repository_id = github_repository.bundle_template.node_id

  enforce_admins          = true
  required_linear_history = true
  require_signed_commits  = true
  allows_deletions        = false
  allows_force_pushes     = false
}

resource "github_branch" "bundle_template" {
  branch     = "master"
  repository = github_repository.bundle_template.id
}

resource "github_branch_default" "bundle_template" {
  branch     = github_branch.bundle_template.branch
  repository = github_repository.bundle_template.id
}
