

resource "aws_s3_bucket" "frontend-web-bucket" {
  bucket = "thuthuhan-frontend-bucket"

  tags = {
    Name        = "frontend-web-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.frontend-web-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.frontend-web-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.frontend-web-bucket.id
  acl    = "public-read"
}



resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.frontend-web-bucket.id
  for_each = fileset("dist", "**")

  key    = each.value
  source = "dist/${each.value}"
  etag   = filemd5("dist/${each.value}")

  content_type = lookup(
    {
      "html" = "text/html",
      "css"  = "text/css",
      "js"   = "application/javascript",
      "json" = "application/json",
      "svg"  = "image/svg+xml",
      "png"  = "image/png",
      "jpg"  = "image/jpeg"
    },
    regex("^.*\\.([^.]+)$", each.value)[0],
    "application/octet-stream"
  )
}



resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.frontend-web-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

