resource "aws_cloudfront_distribution" "shorturl" {
  origin {

    domain_name = "***.ap-southeast-1.elb.amazonaws.com"
    origin_id   = "shorturl_alb"
    custom_origin_config {
      origin_protocol_policy = "match-viewer"
      http_port = "80"
      https_port = "443"
      origin_ssl_protocols = ["TLSv1.2"]
    }

  
}
    default_cache_behavior {
      allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
      cached_methods   = ["GET", "HEAD","OPTIONS"]
      target_origin_id = "shorturl_alb"
      viewer_protocol_policy = "allow-all"

      forwarded_values {
        headers =["*"]
        query_string = true
        cookies {
          forward = "none"
        }
      }
    }

    viewer_certificate {
      acm_certificate_arn = "arn:aws:acm:us-east-1:***:certificate/***"
      minimum_protocol_version = "TLSv1.2_2018"
      ssl_support_method = "sni-only"
  }
    logging_config {
    bucket          = "***"
    include_cookies = false
    prefix          = "shorturl"
    }
  restrictions {
  geo_restriction {
    restriction_type = "none"
  }
}
    enabled = true
    is_ipv6_enabled = false
    comment = "shorturl.org"
    price_class = "PriceClass_200"
    aliases = ["shorturl.org"]
  }