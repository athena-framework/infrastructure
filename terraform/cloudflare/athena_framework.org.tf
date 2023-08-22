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
resource "cloudflare_record" "athena_framework_org_redirect" {
  zone_id = cloudflare_zone.athena_framework_org.id
  name    = "athena-framework.org"
  comment = "https://community.cloudflare.com/t/redirecting-one-domain-to-another/81960"
  value   = "192.0.2.1"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athena_framework_org_www_redirect" {
  zone_id = cloudflare_zone.athena_framework_org.id
  name    = "www"
  value   = "192.0.2.1"
  type    = "A"
  proxied = true
}

# Page Rules
resource "cloudflare_page_rule" "athena_framework_org_redirect" {
  zone_id  = cloudflare_zone.athena_framework_org.id
  target   = "*${cloudflare_zone.athena_framework_org.zone}/*"
  priority = 1

  actions {
    forwarding_url {
      status_code = 301
      url         = "https://athenaframework.org/$2"
    }
  }
}
