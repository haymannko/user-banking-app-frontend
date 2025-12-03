

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.frontend-web-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.frontend-web-bucket.arn}/*"
      }
    ]
  })
}


output "bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}

output "bucket_website_domain" {
  value = aws_s3_bucket_website_configuration.example.website_domain
}