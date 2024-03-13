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

resource "cloudflare_record" "athenaframework_org_dev_pages_cname" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "dev"
  value   = "dev.athenaframework.pages.dev"
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

resource "cloudflare_pages_domain" "dev_athenaframework_org" {
  account_id   = cloudflare_account.blacksmoke16.id
  project_name = cloudflare_pages_project.athenaframework.name
  domain       = "dev.${cloudflare_zone.athenaframework_org.zone}"
}

# Email
resource "cloudflare_record" "athenaframework_org_email_domain_ownership_txt" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = cloudflare_zone.athenaframework_org.zone
  value   = "sl-verification=dnymxbfdjenrigduftapvkqbylloie"
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "athenaframework_org_email_mx1" {
  zone_id  = cloudflare_zone.athenaframework_org.id
  name     = cloudflare_zone.athenaframework_org.zone
  priority = "10"
  value    = "mx1.simplelogin.co."
  type     = "MX"
  proxied  = false
}

resource "cloudflare_record" "athenaframework_org_email_mx2" {
  zone_id  = cloudflare_zone.athenaframework_org.id
  name     = cloudflare_zone.athenaframework_org.zone
  priority = "20"
  value    = "mx2.simplelogin.co."
  type     = "MX"
  proxied  = false
}

resource "cloudflare_record" "athenaframework_org_email_spf_txt" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = cloudflare_zone.athenaframework_org.zone
  value   = "v=spf1 include:simplelogin.co ~all"
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "athenaframework_org_email_dkim1" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "dkim._domainkey"
  value   = "dkim._domainkey.simplelogin.co."
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "athenaframework_org_email_dkim2" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "dkim02._domainkey"
  value   = "dkim02._domainkey.simplelogin.co."
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "athenaframework_org_email_dkim3" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "dkim03._domainkey"
  value   = "dkim03._domainkey.simplelogin.co."
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "athenaframework_org_email_dmarc_txt" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "_dmarc"
  value   = "v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=s"
  type    = "TXT"
  proxied = false
}
