# Route 53 Zone
resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

# ACM Certificate
resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  subject_alternative_names = [var.domain_name]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Certificate DNS Validation Records
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

# ACM Certificate Validation
resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# Route 53 Alias Record for ALB
resource "aws_route53_record" "alb" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

data "cloudflare_zone" "this" {
  zone_id = "4125a60886e1f4aa2f897b1f3f0b9276"
}

# ACM CNAME Records
resource "cloudflare_dns_record" "acm_validation" {
  for_each = { for d in aws_acm_certificate.this.domain_validation_options : d.domain_name => d }

  zone_id = data.cloudflare_zone.this.id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  ttl     = 120
  proxied = false
  content = each.value.resource_record_value
}

# ALB CNAME Record for www
resource "cloudflare_dns_record" "www" {
  zone_id = data.cloudflare_zone.this.id
  name    = "www"
  type    = "CNAME"
  ttl     = 1
  proxied = true
  content = var.alb_dns_name
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"  
    }
  }
}
