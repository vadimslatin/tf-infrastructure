resource "aws_s3_bucket" "practice" {
  bucket = var.bucket_name

  tags = {
    Name    = "${var.project_name}-data"
    Project = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "practice" {
  bucket = aws_s3_bucket.practice.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "practice" {
  bucket = aws_s3_bucket.practice.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "practice" {
  bucket = aws_s3_bucket.practice.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "practice" {
  bucket = aws_s3_bucket.practice.id

  depends_on = [aws_s3_bucket_versioning.practice]

  rule {
    id     = "expire-after-${var.object_expiration_days}-days"
    status = "Enabled"

    filter {}

    expiration {
      days = var.object_expiration_days
    }

    noncurrent_version_expiration {
      noncurrent_days = var.object_expiration_days
    }
  }
}
