resource "aws_s3_bucket" "hieunh40xk-bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_public_access_block" "hieunh40xk-bucket" {
  bucket = aws_s3_bucket.hieunh40xk-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "hieunh40xk-bucket" {
  bucket = aws_s3_bucket.hieunh40xk-bucket.id

  index_document {
    suffix = var.suffix
  }
  error_document {
    key = var.error
  }
}

resource "aws_s3_bucket_ownership_controls" "hieunh40xk-bucket" {
  bucket = aws_s3_bucket.hieunh40xk-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "hieunh40xk-bucket" {
  bucket = aws_s3_bucket.hieunh40xk-bucket.id
  acl    = var.acl

  depends_on = [
    aws_s3_bucket_ownership_controls.hieunh40xk-bucket
  ]
}

resource "aws_s3_bucket_policy" "hieunh40xk-bucket" {
  bucket = aws_s3_bucket.hieunh40xk-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.hieunh40xk-bucket.arn,
          "${aws_s3_bucket.hieunh40xk-bucket.arn}/*",
        ]
      },
    ]
  })
  #    depends_on = [ 
  #        aws_s3_bucket_public_access_block.hieunh40xk-bucket.id
  #     ] 
}