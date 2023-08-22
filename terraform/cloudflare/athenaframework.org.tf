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

resource "cloudflare_record" "athenaframework_org_github_redirect_one" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "athenaframework.org"
  value   = "185.199.108.153"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athenaframework_org_github_redirect_two" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "athenaframework.org"
  value   = "185.199.109.153"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athenaframework_org_github_redirect_three" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "athenaframework.org"
  value   = "185.199.110.153"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athenaframework_org_github_redirect_four" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "athenaframework.org"
  value   = "185.199.111.153"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "athenaframework_org_txt_github_pages_verification" {
  zone_id = cloudflare_zone.athenaframework_org.id
  name    = "_github-pages-challenge-athena-framework"
  value   = "5f9524b2b091ccf849e9717bc2b4ca"
  type    = "TXT"
  proxied = false
}
