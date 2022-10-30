variable "name" {
  description = "The name of the component's repository"
  type        = string
  nullable    = false
}

variable "description" {
  description = "The description of the component's repository"
  type        = string
  nullable    = false
}

variable "url" {
  description = "The URL to the documentation of the component"
  type        = string
  nullable    = true
}

variable "topics" {
  description = "The URL to the documentation of the component"
  type        = list(string)
  nullable    = false
}

variable "branch" {
  description = "The name of the default branch for the component"
  type        = string
  nullable    = false
  default     = "master"
}

variable "visibility" {
  description = "The visibility of the component repository"
  type        = string
  default     = "public"
  nullable    = false
  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "Visibility must be one of 'public' or 'private'"
  }
}

variable "ci_team" {
  description = "The node ID of the GH team that has access to the component"
  type = object({
    id      = number
    node_id = string
  })
  nullable = false
}
