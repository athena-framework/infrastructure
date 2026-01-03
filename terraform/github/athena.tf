locals {
  labels = {
    "breaking" = {
      "color" = "D93F0B"
    }
    "good first issue" = {
      "color" = "84F49F"
    }
    "help wanted" = {
      "color" = "D3C804"
    }

    "component:ecosystem" = {
      "color"       = "BBD8F2"
      "description" = "Affects all components in the ecosystem"
    }

    "kind:bug" = {
      "color"       = "D73A4A"
      "description" = "An existing feature isn't working as expected"
    }
    "kind:documentation" = {
      "color" = "032ED7"
    }
    "kind:enhancement" = {
      "color"       = "FBCBB2"
      "description" = "New functionality to an existing feature"
    }
    "kind:feature" = {
      "color"       = "55DCFC"
      "description" = "Brand new functionality"
    }
    "kind:maintenance" = {
      "color"       = "A6BE14"
      "description" = "Keeping an existing feature functional"
    }
    "kind:infrastructure" = {
      "color" = "000000"
    }
    "kind:question" = {
      "color" = "D876E3"
    }
    "kind:refactor" = {
      "color" = "38779E"
    }
    "kind:regression" = {
      "color" = "FF0000"
    }
    "kind:release" = {
      "color" = "92E94A"
    }
    "kind:RFC" = {
      "color" = "434A1D"
    }
    "kind:specs" = {
      "color" = "87DFA9"
    }

    "state:blocked" = {
      "color" = "B60205"
    }
    "state:duplicate" = {
      "color" = "FEF2C0"
    }
    "state:needs-more-info" = {
      "color" = "F38A20"
    }
    "state:rejected" = {
      "color" = "6FE1E2"
    }

    "type:performance" = {
      "color" = "80D944"
    }
  }
}

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
  allow_merge_commit          = true # This is needed for adding new subtrees
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

resource "github_branch_protection" "athena" {
  pattern       = github_branch_default.athena.branch
  repository_id = github_repository.athena.node_id

  enforce_admins          = true
  required_linear_history = true
  allows_deletions        = false
  allows_force_pushes     = false

  required_status_checks {
    strict = true
    contexts = [
      "coding_standards",
      "check_format (latest)",
      "check_spelling",
      "test_compiled (latest)",
      "test_unit (macos-latest, latest)",
      "test_unit (ubuntu-latest, latest)",
      "test_unit (windows-latest, latest)",
      "test_unit (ubuntu-24.04-arm, latest)",
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

resource "github_issue_label" "athena" {
  for_each = local.labels

  repository  = "athena"
  name        = each.key
  color       = lookup(each.value, "color")
  description = lookup(each.value, "description", null)
}
