output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.hieunh40xk-bucket.arn
}

output "name" {
  description = "Name or id of the bucket"
  value       = aws_s3_bucket.hieunh40xk-bucket.id
}