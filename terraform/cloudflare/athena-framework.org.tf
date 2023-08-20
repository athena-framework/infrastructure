# Zone
resource "cloudflare_zone" "athena-framework-org" {
  account_id = cloudflare_account.blacksmoke16.id
  zone       = "athena-framework.org"
  plan       = "free"
  type       = "full"
}

resource "cloudflare_zone_dnssec" "athena-framework-org" {
  zone_id = cloudflare_zone.athena-framework-org.id
}

resource "cloudflare_zone_settings_override" "athena-framework-org" {
  zone_id = cloudflare_zone.athena-framework-org.id

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
resource "cloudflare_record" "athena-framework-org-A-athena-framework-org" {
  zone_id = cloudflare_zone.athena-framework-org.id
  name    = "athena-framework.org"
  comment = "https://community.cloudflare.com/t/redirecting-one-domain-to-another/81960"
  value   = "192.0.2.1"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athena-framework-org-A-www" {
  zone_id = cloudflare_zone.athena-framework-org.id
  name    = "www"
  value   = "192.0.2.1"
  type    = "A"
  proxied = true
}

# Page Rules
resource "cloudflare_page_rule" "athena-framework-org-redirect" {
  zone_id  = cloudflare_zone.athena-framework-org.id
  target   = "*${cloudflare_zone.athena-framework-org.zone}/*"
  priority = 1

  actions {
    forwarding_url {
      status_code = 301
      url         = "https://athenaframework.org/$2"
    }
  }
}
