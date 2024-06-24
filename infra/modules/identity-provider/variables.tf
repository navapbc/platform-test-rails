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
  default     = null
}

variable "reply_to_email" {
  type        = string
  description = "Email address used as the REPLY-TO for identity service emails"
  default     = null
}

variable "password_minimum_length" {
  type        = number
  description = "The password minimum length"
  default     = 12
}

variable "temporary_password_validity_days" {
  type        = number
  description = "The number of days a temporary password is valid for"
  default     = 7
}

variable "invite_email_message" {
  type        = string
  description = "The email body for an account invitation email sent by an admin user. Must contain {username} and {####} placeholders, for username and temporary password, respectively."
  default     = null
}

variable "invite_email_subject" {
  type        = string
  description = "The email subject for an account invitation email sent by an admin user"
  default     = null
}

variable "verification_email_message" {
  type        = string
  description = "The email body for a password reset email. Must contain the {####} placeholder."
  default     = null
}

variable "verification_email_subject" {
  type        = string
  description = "The email subject for a password reset email"
  default     = null
}

variable "is_temporary" {
  description = "Whether the service is meant to be spun up temporarily (e.g. for automated infra tests). This is used to disable deletion protection."
  type        = bool
  default     = false
}