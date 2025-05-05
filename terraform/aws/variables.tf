variable "account_id" {
  description = "AWS account ID to create the resources in"
  type        = string
  sensitive   = true
  nullable    = false
}
