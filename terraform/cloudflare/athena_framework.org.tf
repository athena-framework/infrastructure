# Zone
resource "cloudflare_zone" "athena_framework_org" {
  account_id = cloudflare_account.blacksmoke16.id
  zone       = "athena-framework.org"
  plan       = "free"
  type       = "full"
}

resource "cloudflare_zone_dnssec" "athena_framework_org" {
  zone_id = cloudflare_zone.athena_framework_org.id
}

resource "cloudflare_zone_settings_override" "athena_framework_org" {
  zone_id = cloudflare_zone.athena_framework_org.id

  settings {
    automatic_https_rewrites = "on"
    always_use_https         = "on"
    brotli                   = "on"
    ssl                      = "full"
    security_header {
      enabled            = true
      max_age            = 31536000
      include_subdomains = true
      nosniff            = true
      preload            = true
    }
  }
}

# DNS Records
# This lets things resolve, with the actual redirect being handled by Page Redirect Rules
resource "cloudflare_record" "athena_framework_org_redirect" {
  zone_id = cloudflare_zone.athena_framework_org.id
  name    = "athena-framework.org"
  comment = "https://developers.cloudflare.com/fundamentals/setup/manage-domains/redirect-domain/"
  content = "192.0.2.1"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athena_framework_org_www_redirect" {
  zone_id = cloudflare_zone.athena_framework_org.id
  name    = "www"
  comment = "https://developers.cloudflare.com/fundamentals/setup/manage-domains/redirect-domain/"
  content = "192.0.2.1"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athena_framework_org_dev_cname" {
  zone_id = cloudflare_zone.athena_framework_org.id
  name    = "dev"
  comment = "https://developers.cloudflare.com/fundamentals/setup/manage-domains/redirect-domain/"
  content = "192.0.2.1"
  type    = "A"
  proxied = true
}

# Redirect traffic from `athena-framework.org` to `athenaframework.org`
resource "cloudflare_ruleset" "default" {
  zone_id     = cloudflare_zone.athena_framework_org.id
  name        = "redirects"
  description = "Redirect ruleset"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    action      = "redirect"
    description = "Root Redirect"
    enabled     = true
    expression  = "(http.host eq \"athena-framework.org\") or (http.host eq \"www.athena-framework.org\")"

    action_parameters {
      from_value {
        preserve_query_string = true
        status_code           = 301

        target_url {
          expression = "concat(\"https://athenaframework.org\", http.request.uri.path)"
        }
      }
    }
  }

  rules {
    action      = "redirect"
    description = "Dev Redirect"
    enabled     = true
    expression  = "(http.host eq \"dev.athena-framework.org\")"

    action_parameters {
      from_value {
        preserve_query_string = true
        status_code           = 301

        target_url {
          expression = "concat(\"https://dev.athenaframework.org\", http.request.uri.path)"
        }
      }
    }
  }
}
