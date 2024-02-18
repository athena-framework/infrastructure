# Zone
resource "cloudflare_zone" "athenaframework_org" {
  account_id = cloudflare_account.blacksmoke16.id
  zone       = "athenaframework.org"
  plan       = "free"
  type       = "full"
}

resource "cloudflare_zone_dnssec" "athenaframework_org" {
  zone_id = cloudflare_zone.athenaframework_org.id
}

resource "cloudflare_zone_settings_override" "athenaframework_org" {
  zone_id = cloudflare_zone.athenaframework_org.id

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
resource "cloudflare_record" "athenaframework_org_www_cname" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "www"
  value   = "athenaframework.org"
  type    = "CNAME"
  proxied = true
}
