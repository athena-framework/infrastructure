module "config_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "config"
  description = "Common library for configuring Athena components"
  url         = "https://athenaframework.org/Config/"
  topics      = ["crystal"]
}

module "console_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "console"
  description = "Allows for the creation of CLI based commands"
  url         = "https://athenaframework.org/Console/"
  topics      = ["crystal"]
}

module "dependency-injection_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "dependency-injection"
  description = "Robust dependency injection service container framework"
  url         = "https://athenaframework.org/DependencyInjection/"
  topics      = ["crystal", "dependency-injection"]
}

module "event-dispatcher_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "event-dispatcher"
  description = "A Mediator and Observer pattern event library"
  url         = "https://athenaframework.org/EventDispatcher/"
  topics      = ["crystal"]
}

module "framework_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "framework"
  description = "A web framework created from various Athena components"
  url         = "https://athenaframework.org/Framework/"
  topics      = ["crystal"]
}

module "image-size_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "image-size"
  description = "Measures the size of various image formats"
  url         = "https://athenaframework.org/ImageSize/"
  topics      = ["crystal"]
}

module "negotiation_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "negotiation"
  description = "Framework agnostic content negotiation library"
  url         = "https://athenaframework.org/Negotiation/"
  topics      = ["crystal"]
}

module "routing_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "routing"
  description = "Robust and performant HTTP routing library"
  url         = "https://athenaframework.org/Routing/"
  topics      = ["crystal"]
}

module "serializer_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "serializer"
  description = "Flexible object (de)serialization library"
  url         = "https://athenaframework.org/Serializer/"
  topics      = ["crystal"]
}

module "spec_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "spec"
  description = "Common/helpful Spec compliant testing utilities"
  url         = "https://athenaframework.org/Spec/"
  topics      = ["crystal", "testing", "spec"]
}

module "validator_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "validator"
  description = "Object/value validation library"
  url         = "https://athenaframework.org/Validator/"
  topics      = ["crystal", "validation"]
}
