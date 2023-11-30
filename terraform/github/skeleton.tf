resource "github_repository" "skeleton" {
  name                        = "skeleton"
  description                 = "Template repo to get up and running quickly with the Athena Framework"
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

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch" "skeleton" {
  branch     = "master"
  repository = github_repository.skeleton.id
}

resource "github_branch_default" "skeleton" {
  branch     = github_branch.skeleton.branch
  repository = github_repository.skeleton.id
}
