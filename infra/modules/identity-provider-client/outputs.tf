output "client_id" {
  description = "The ID of the user pool client"
  value       = aws_cognito_user_pool_client.client.id
}

output "access_policy_arn" {
  value = aws_iam_policy.cognito_access.arn
}
