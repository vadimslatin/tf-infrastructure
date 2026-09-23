output "bucket_name" {
  description = "Name of the practice S3 bucket"
  value       = aws_s3_bucket.practice.bucket
}

output "bucket_arn" {
  description = "ARN of the practice S3 bucket"
  value       = aws_s3_bucket.practice.arn
}

output "bucket_region" {
  description = "Region of the practice S3 bucket"
  value       = aws_s3_bucket.practice.region
}
