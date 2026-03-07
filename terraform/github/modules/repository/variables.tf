variable "type" {
  description = "The type of repository"
  type        = string
  nullable    = false
  default     = "component"
  validation {
    condition     = contains(["component", "bundle"], var.type)
    error_message = "Type must be one of 'component' or 'bundle'"
  }
}

variable "organization" {
  description = "The GitHub organization that owns the template repository"
  type        = string
  nullable    = false
}

variable "name" {
  description = "The name of the repository"
  type        = string
  nullable    = false
}

variable "description" {
  description = "The description of the repository"
  type        = string
  nullable    = false
}

variable "url" {
  description = "The URL to the documentation of the repository"
  type        = string
  nullable    = true
}

variable "topics" {
  description = "The repository topics"
  type        = list(string)
  nullable    = false
}

variable "branch" {
  description = "The name of the default branch"
  type        = string
  nullable    = false
  default     = "master"
}

variable "visibility" {
  description = "The visibility of the repository"
  type        = string
  default     = "public"
  nullable    = false
  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "Visibility must be one of 'public' or 'private'"
  }
}

variable "ci_team" {
  description = "The node ID of the GH team that has access to the repository"
  type = object({
    id      = number
    node_id = string
  })
  nullable = false
}

variable "deprecated" {
  description = "Deprecated repositories are archived on GH"
  type        = bool
  nullable    = false
  default     = false
}

variable "historic" {
  description = "Historic repositories were not created using the GH template repo"
  type        = bool
  nullable    = false
  default     = false
}
