locals {
  topics = ["crystal"]
}

module "clock_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "clock"
  description = "Decouples applications from the system clock"
  url         = "https://athenaframework.org/Clock/"
  topics      = concat(local.topics, ["time", "clock"])
}

module "config_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "config"
  description = "Common library for configuring Athena components"
  url         = "https://athenaframework.org/Config/"
  topics      = local.topics
}

module "console_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "console"
  description = "Allows for the creation of CLI based commands"
  url         = "https://athenaframework.org/Console/"
  topics      = local.topics
}

module "dependency_injection_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "dependency-injection"
  description = "Robust dependency injection service container framework"
  url         = "https://athenaframework.org/DependencyInjection/"
  topics      = concat(local.topics, ["dependency-injection"])
}

module "dotenv_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "dotenv"
  description = "Registers environment variables from a .env file"
  url         = "https://athenaframework.org/Dotenv/"
  topics      = local.topics
}

module "event_dispatcher_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "event-dispatcher"
  description = "A Mediator and Observer pattern event library"
  url         = "https://athenaframework.org/EventDispatcher/"
  topics      = local.topics
}

module "framework_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "framework"
  description = "A web framework created from various Athena components"
  url         = "https://athenaframework.org/Framework/"
  topics      = local.topics
}

module "image_size_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "image-size"
  description = "Measures the size of various image formats"
  url         = "https://athenaframework.org/ImageSize/"
  topics      = local.topics
}

module "mercure_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "mercure"
  description = "Allows easily pushing updates to web browsers and other HTTP clients using the Mercure protocol"
  url         = "https://athenaframework.org/Mercure/"
  topics      = concat(local.topics, ["mercure", "server-sent-events"])
}

module "negotiation_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "negotiation"
  description = "Framework agnostic content negotiation library"
  url         = "https://athenaframework.org/Negotiation/"
  topics      = local.topics
}

module "routing_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "routing"
  description = "Robust and performant HTTP routing library"
  url         = "https://athenaframework.org/Routing/"
  topics      = local.topics
}

module "serializer_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "serializer"
  description = "Flexible object (de)serialization library"
  url         = "https://athenaframework.org/Serializer/"
  topics      = local.topics
}

module "spec_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "spec"
  description = "Common/helpful Spec compliant testing utilities"
  url         = "https://athenaframework.org/Spec/"
  topics      = concat(local.topics, ["testing", "spec"])
}

module "validator_component" {
  source = "./modules/component"

  ci_team     = github_team.ci
  name        = "validator"
  description = "Object/value validation library"
  url         = "https://athenaframework.org/Validator/"
  topics      = concat(local.topics, ["validation"])
}
