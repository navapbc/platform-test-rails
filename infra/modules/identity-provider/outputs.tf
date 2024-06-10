output "endpoint" {
  description = "The public endpoint for the identity service."
  value       = aws_cognito_user_pool.main.endpoint
}
