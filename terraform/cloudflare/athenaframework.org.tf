# Zone
resource "cloudflare_zone" "athenaframework_org" {
  account = {
    id = cloudflare_account.blacksmoke16.id
  }
  name = "athenaframework.org"
  type = "full"
}

resource "cloudflare_zone_dnssec" "athenaframework_org" {
  zone_id = cloudflare_zone.athenaframework_org.id
}

resource "cloudflare_zone_setting" "athenaframework_org-automatic_https_rewrites" {
  zone_id    = cloudflare_zone.athenaframework_org.id
  setting_id = "automatic_https_rewrites"
  value      = "on"
}

resource "cloudflare_zone_setting" "athenaframework_org-always_use_https" {
  zone_id    = cloudflare_zone.athenaframework_org.id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_zone_setting" "athenaframework_org-brotli" {
  zone_id    = cloudflare_zone.athenaframework_org.id
  setting_id = "brotli"
  value      = "on"
}

resource "cloudflare_zone_setting" "athenaframework_org-ssl" {
  zone_id    = cloudflare_zone.athenaframework_org.id
  setting_id = "ssl"
  value      = "full"
}

resource "cloudflare_zone_setting" "athenaframework_org-security_header" {
  zone_id    = cloudflare_zone.athenaframework_org.id
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
resource "cloudflare_dns_record" "athenaframework_org_www_cname" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "www"
  content = "athenaframework.org"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "athenaframework_org_pages_cname" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = cloudflare_zone.athenaframework_org.name
  content = "athenaframework.pages.dev"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "athenaframework_org_dev_pages_cname" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "dev"
  content = "dev.athenaframework.pages.dev"
  type    = "CNAME"
  ttl     = 1
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
  name         = cloudflare_zone.athenaframework_org.name
}

resource "cloudflare_pages_domain" "dev_athenaframework_org" {
  account_id   = cloudflare_account.blacksmoke16.id
  project_name = cloudflare_pages_project.athenaframework.name
  name         = "dev.${cloudflare_zone.athenaframework_org.name}"
}

# Email
resource "cloudflare_dns_record" "athenaframework_org_email_domain_ownership_txt" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = cloudflare_zone.athenaframework_org.name
  content = "sl-verification=dnymxbfdjenrigduftapvkqbylloie"
  type    = "TXT"
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "athenaframework_org_email_mx1" {
  zone_id  = cloudflare_zone.athenaframework_org.id
  name     = cloudflare_zone.athenaframework_org.name
  priority = "10"
  content  = "mx1.simplelogin.co."
  type     = "MX"
  ttl      = 1
  proxied  = false
}

resource "cloudflare_dns_record" "athenaframework_org_email_mx2" {
  zone_id  = cloudflare_zone.athenaframework_org.id
  name     = cloudflare_zone.athenaframework_org.name
  priority = "20"
  content  = "mx2.simplelogin.co."
  type     = "MX"
  ttl      = 1
  proxied  = false
}

resource "cloudflare_dns_record" "athenaframework_org_email_spf_txt" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = cloudflare_zone.athenaframework_org.name
  content = "v=spf1 include:simplelogin.co ~all"
  type    = "TXT"
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "athenaframework_org_email_dkim1" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "dkim._domainkey"
  content = "dkim._domainkey.simplelogin.co."
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "athenaframework_org_email_dkim2" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "dkim02._domainkey"
  content = "dkim02._domainkey.simplelogin.co."
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "athenaframework_org_email_dkim3" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "dkim03._domainkey"
  content = "dkim03._domainkey.simplelogin.co."
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "athenaframework_org_email_dmarc_txt" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "_dmarc"
  content = "v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=s"
  type    = "TXT"
  ttl     = 1
  proxied = false
}
