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

resource "cloudflare_record" "athenaframework_org_pages_cname" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = cloudflare_zone.athenaframework_org.zone
  value   = "athenaframework.pages.dev"
  type    = "CNAME"
  proxied = true
}

# Pages
resource "cloudflare_pages_project" "athenaframework" {
  account_id        = cloudflare_account.blacksmoke16.id
  name              = "athenaframework"
  production_branch = "master"
}

resource "cloudflare_pages_domain" "athenaframework_org" {
  account_id   = cloudflare_account.blacksmoke16.id
  project_name = cloudflare_pages_project.athenaframework.name
  domain       = cloudflare_zone.athenaframework_org.zone
}
