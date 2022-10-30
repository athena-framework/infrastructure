locals {
  components = {
    "config" = {
      "description" = "Common library for configuring Athena components"
      "url"         = "https://athenaframework.org/Config/"
      "topics"      = ["crystal"]
    }
    "console" = {
      "description" = "Allows for the creation of CLI based commands"
      "url"         = "https://athenaframework.org/Console/"
      "topics"      = ["crystal"]
    }
    "dependency-injection" = {
      "description" = "Robust dependency injection service container framework"
      "url"         = "https://athenaframework.org/DependencyInjection/"
      "topics"      = ["crystal", "dependency-injection"]
    }
    "event-dispatcher" = {
      "description" = "A Mediator and Observer pattern event library"
      "url"         = "https://athenaframework.org/EventDispatcher/"
      "topics"      = ["crystal"]
    }
    "image-size" = {
      "description" = "Measures the size of various image formats"
      "url"         = "https://athenaframework.org/ImageSize/"
      "topics"      = ["crystal"]
    }
    "negotiation" = {
      "description" = "Framework agnostic content negotiation library"
      "url"         = "https://athenaframework.org/Negotiation/"
      "topics"      = ["crystal"]
    }
    "routing" = {
      "description" = "Robust and performant HTTP routing library"
      "url"         = "https://athenaframework.org/Routing/"
      "topics"      = ["crystal"]
    }
    "serializer" = {
      "description" = "Flexible object (de)serialization library"
      "url"         = "https://athenaframework.org/Serializer/"
      "topics"      = ["crystal"]
    }
    "spec" = {
      "description" = "Common/helpful Spec compliant testing utilities"
      "url"         = "https://athenaframework.org/Spec/"
      "topics"      = ["crystal", "testing", "spec"]
    }
    "validator" = {
      "description" = "Object/value validation library"
      "url"         = "https://athenaframework.org/Validator/"
      "topics"      = ["crystal", "validation"]
    }
  }
}

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

resource "github_team_repository" "ci" {
  for_each = local.components

  repository = github_repository.component[each.key].id
  team_id    = github_team.ci.id
  permission = "push"
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

# Components

resource "github_repository" "component" {
  for_each = local.components

  name                        = each.key
  description                 = each.value.description
  visibility                  = lookup(each.value, "visibility", "public")
  homepage_url                = lookup(each.value, "url", null)
  topics                      = each.value.topics
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

resource "github_branch_protection" "component" {
  for_each = local.components

  pattern       = "master"
  repository_id = github_repository.component[each.key].node_id

  enforce_admins          = true
  required_linear_history = true
  blocks_creations        = true

  required_pull_request_reviews {
    required_approving_review_count = 0
    pull_request_bypassers = [
      github_team.ci.node_id
    ]
  }

  # TODO: Restrict creating matching branches
  push_restrictions = [
    github_team.ci.node_id
  ]
}

resource "github_branch" "component" {
  for_each = local.components

  branch     = "master"
  repository = github_repository.component[each.key].id
}

resource "github_branch_default" "component" {
  for_each = local.components

  branch     = github_branch.component[each.key].branch
  repository = github_repository.component[each.key].id
}
