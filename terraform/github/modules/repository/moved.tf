# With the introduction of bundles, the internal name of the `component` module were made into a more generic `repository` module.
moved {
  from = github_repository.component
  to   = github_repository.this
}

moved {
  from = github_actions_repository_permissions.component
  to   = github_actions_repository_permissions.this
}

moved {
  from = github_issue_label.component
  to   = github_issue_label.this
}
