module "clock_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "clock"
  description  = "Decouples applications from the system clock"
  url          = "${local.base_url}/Clock/"
  topics       = concat(local.topics, ["time", "clock"])
}

module "config_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "config"
  description  = "Common library for configuring Athena components"
  url          = "${local.base_url}/Config/"
  topics       = local.topics
  deprecated   = true
  historic     = true
}

module "console_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "console"
  description  = "Allows for the creation of CLI based commands"
  url          = "${local.base_url}/Console/"
  topics       = local.topics
}

module "contracts_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "contracts"
  description  = "A set of abstractions extracted out of the Athena components"
  url          = "${local.base_url}/Contracts/"
  topics       = concat(local.topics, ["crystal", "abstractions", "standards", "interoperability", "contracts", "decoupling", "interfaces"])
}

module "dependency_injection_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "dependency-injection"
  description  = "Robust dependency injection service container framework"
  url          = "${local.base_url}/DependencyInjection/"
  topics       = concat(local.topics, ["dependency-injection"])
  historic     = true
}

module "dotenv_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "dotenv"
  description  = "Registers environment variables from a .env file"
  url          = "${local.base_url}/Dotenv/"
  topics       = local.topics
}

module "event_dispatcher_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "event-dispatcher"
  description  = "A Mediator and Observer pattern event library"
  url          = "${local.base_url}/EventDispatcher/"
  topics       = local.topics
  historic     = true
}

module "framework_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "framework"
  description  = "A web framework created from various Athena components"
  url          = "${local.base_url}/Framework/"
  topics       = local.topics
  historic     = true
}

module "http_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "http"
  description  = "Shared common HTTP abstractions/utilities"
  url          = "${local.base_url}/HTTP/"
  topics       = local.topics
}

module "http_kernel_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "http-kernel"
  description  = "Provides a structured process for converting a Request into a Response"
  url          = "${local.base_url}/HTTPKernel/"
  topics       = local.topics
}

module "image_size_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "image-size"
  description  = "Measures the size of various image formats"
  url          = "${local.base_url}/ImageSize/"
  topics       = local.topics
}

module "mercure_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "mercure"
  description  = "Allows easily pushing updates to web browsers and other HTTP clients using the Mercure protocol"
  url          = "${local.base_url}/Mercure/"
  topics       = concat(local.topics, ["mercure", "server-sent-events"])
}

module "mime_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "mime"
  description  = "Allows manipulating MIME messages"
  url          = "${local.base_url}/MIME/"
  topics       = concat(local.topics, ["mime", "mime-type"])
}

module "negotiation_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "negotiation"
  description  = "Framework agnostic content negotiation library"
  url          = "${local.base_url}/Negotiation/"
  topics       = local.topics
}

module "routing_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "routing"
  description  = "Robust and performant HTTP routing library"
  url          = "${local.base_url}/Routing/"
  topics       = local.topics
}

module "serializer_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "serializer"
  description  = "Flexible object (de)serialization library"
  url          = "${local.base_url}/Serializer/"
  topics       = local.topics
}

module "spec_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "spec"
  description  = "Common/helpful Spec compliant testing utilities"
  url          = "${local.base_url}/Spec/"
  topics       = concat(local.topics, ["testing", "spec"])
}

module "validator_component" {
  source = "./modules/component"

  ci_team      = github_team.ci
  organization = local.organization
  name         = "validator"
  description  = "Object/value validation library"
  url          = "${local.base_url}/Validator/"
  topics       = concat(local.topics, ["validation"])
}
