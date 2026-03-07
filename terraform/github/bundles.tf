module "mercure_bundle" {
  source = "./modules/repository"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "mercure-bundle"
  description  = "Integrates the Athena Mercure component into the framework"
  url          = "${local.base_url}/MercureBundle/"
  topics       = local.topics
  type         = "bundle"
}
