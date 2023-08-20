# Zone
resource "cloudflare_zone" "athenaframework-org" {
  account_id = cloudflare_account.blacksmoke16.id
  zone       = "athenaframework.org"
  plan       = "free"
  type       = "full"
}

resource "cloudflare_zone_dnssec" "athenaframework-org" {
  zone_id = cloudflare_zone.athenaframework-org.id
}

resource "cloudflare_zone_settings_override" "athenaframework-org" {
  zone_id = cloudflare_zone.athenaframework-org.id

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
resource "cloudflare_record" "athenaframework-org-CNAME-www" {
  zone_id = cloudflare_zone.athenaframework-org.id
  name    = "www"
  value   = "athenaframework.org"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "athenaframework-org-A-GH-1" {
  zone_id = cloudflare_zone.athenaframework-org.id
  name    = "athenaframework.org"
  value   = "185.199.108.153"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athenaframework-org-A-GH-2" {
  zone_id = cloudflare_zone.athenaframework-org.id
  name    = "athenaframework.org"
  value   = "185.199.109.153"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athenaframework-org-A-GH-3" {
  zone_id = cloudflare_zone.athenaframework-org.id
  name    = "athenaframework.org"
  value   = "185.199.110.153"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athenaframework-org-A-GH-4" {
  zone_id = cloudflare_zone.athenaframework-org.id
  name    = "athenaframework.org"
  value   = "185.199.111.153"
  type    = "A"
  proxied = true
}
