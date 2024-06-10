data "aws_ses_email_identity" "sender" {
  count = var.sender_email != null ? 1 : 0
  email = var.sender_email
}

resource "aws_cognito_user_pool" "main" {
  name = var.name

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  device_configuration {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = true
  }

  email_configuration {
    # Use this SES email to send cognito emails. If we're not using SES for emails then use null
    source_arn            = var.sender_email != null ? data.aws_ses_email_identity.sender[0].arn : null
    email_sending_account = var.sender_email != null ? "DEVELOPER" : "COGNITO_DEFAULT"
    # Customize the name that users see in the "From" section of their inbox, so that it's clearer who the email is from.
    # This name also needs to be updated manually in the Cognito console for each environment's Advanced Security emails.
    #
    # Note that this name should _also_ match what is being sent by ServiceNow. If they ever change their sender name
    # or we change ours, we need coordination to keep them in sync and provide a consistent user experience.
    from_email_address = var.sender_email != null ? "${var.sender_display_name} <${var.sender_email}>" : null
  }

  password_policy {
    minimum_length                   = 12
    temporary_password_validity_days = 7
  }

  mfa_configuration = "OPTIONAL"
  software_token_mfa_configuration {
    enabled = true
  }

  user_pool_add_ons {
    advanced_security_mode = "AUDIT"
  }

  username_configuration {
    case_sensitive = false
  }

  user_attribute_update_settings {
    attributes_require_verification_before_update = ["email"]
  }
}
