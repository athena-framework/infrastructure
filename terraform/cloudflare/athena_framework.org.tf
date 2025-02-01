# Zone
resource "cloudflare_zone" "athena_framework_org" {
  account = {
    id = cloudflare_account.blacksmoke16.id
  }
  name = "athena-framework.org"
  type = "full"
}

resource "cloudflare_zone_dnssec" "athena_framework_org" {
  zone_id = cloudflare_zone.athena_framework_org.id
}

resource "cloudflare_zone_setting" "athena_framework_org-automatic_https_rewrites" {
  zone_id    = cloudflare_zone.athena_framework_org.id
  setting_id = "automatic_https_rewrites"
  value      = "on"
}

resource "cloudflare_zone_setting" "athena_framework_org-always_use_https" {
  zone_id    = cloudflare_zone.athena_framework_org.id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_zone_setting" "athena_framework_org-brotli" {
  zone_id    = cloudflare_zone.athena_framework_org.id
  setting_id = "brotli"
  value      = "on"
}

resource "cloudflare_zone_setting" "athena_framework_org-ssl" {
  zone_id    = cloudflare_zone.athena_framework_org.id
  setting_id = "ssl"
  value      = "full"
}

resource "cloudflare_zone_setting" "athena_framework_org-security_header" {
  zone_id    = cloudflare_zone.athena_framework_org.id
  setting_id = "security_header"
  value = [{
    enabled            = true
    max_age            = 31536000
    include_subdomains = true
    nosniff            = true
    preload            = true
  }]
}

# DNS Records
# This lets things resolve, with the actual redirect being handled by Page Redirect Rules
resource "cloudflare_dns_record" "athena_framework_org_redirect" {
  zone_id = cloudflare_zone.athena_framework_org.id
  name    = "athena-framework.org"
  comment = "https://developers.cloudflare.com/fundamentals/setup/manage-domains/redirect-domain/"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "athena_framework_org_www_redirect" {
  zone_id = cloudflare_zone.athena_framework_org.id
  name    = "www"
  comment = "https://developers.cloudflare.com/fundamentals/setup/manage-domains/redirect-domain/"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "athena_framework_org_dev_cname" {
  zone_id = cloudflare_zone.athena_framework_org.id
  name    = "dev"
  comment = "https://developers.cloudflare.com/fundamentals/setup/manage-domains/redirect-domain/"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 1
  proxied = true
}

# Redirect traffic from `athena-framework.org` to `athenaframework.org`
# resource "cloudflare_ruleset" "default" {
#   zone_id     = cloudflare_zone.athena_framework_org.id
#   name        = "redirects"
#   description = "Redirect ruleset"
#   kind        = "zone"
#   phase       = "http_request_dynamic_redirect"

#   rules = [
#     {
#       action      = "redirect"
#       description = "Root Redirect"
#       enabled     = true
#       expression  = "(http.host eq \"athena-framework.org\") or (http.host eq \"www.athena-framework.org\")"

#       action_parameters = {
#         from_value = {
#           preserve_query_string = true
#           status_code           = 301

#           target_url = {
#             expression = "concat(\"https://athenaframework.org\", http.request.uri.path)"
#           }
#         }
#       }
#     },
#     {
#       action      = "redirect"
#       description = "Dev Redirect"
#       enabled     = true
#       expression  = "(http.host eq \"dev.athena-framework.org\")"

#       action_parameters = {
#         from_value = {
#           preserve_query_string = true
#           status_code           = 301

#           target_url = {
#             expression = "concat(\"https://dev.athenaframework.org\", http.request.uri.path)"
#           }
#         }
#       }
#     }
#   ]

# }
