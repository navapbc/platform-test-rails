variable "name" {
  type        = string
  description = "The name of the Cognito User Pool"
}

variable "sender_email" {
  type        = string
  description = "Email address to use to send identity provider emails. If none is provided, the identity service will be configured to use Cognito's default email functionality, which should only be relied on outside of production."
  default     = null
}

variable "sender_display_name" {
  type        = string
  description = "The display name for the identity service's emails. Only used if sender_email is provided"
  default     = "value"
}
