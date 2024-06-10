output "account_name" {
  value       = var.account_name
  description = "Name of the AWS account that contains the resources for the application environment."
}

output "database_config" {
  value = var.has_database ? {
    region                      = var.default_region
    cluster_name                = "${var.app_name}-${var.environment}"
    app_username                = "app"
    migrator_username           = "migrator"
    schema_name                 = var.app_name
    app_access_policy_name      = "${var.app_name}-${var.environment}-app-access"
    migrator_access_policy_name = "${var.app_name}-${var.environment}-migrator-access"
  } : null
}

output "network_name" {
  value = var.network_name
}

output "service_config" {
  value = {
    service_name             = "${local.prefix}${var.app_name}-${var.environment}"
    domain_name              = var.domain_name
    enable_https             = var.enable_https
    region                   = var.default_region
    cpu                      = var.service_cpu
    memory                   = var.service_memory
    desired_instance_count   = var.service_desired_instance_count
    enable_command_execution = var.enable_command_execution

    extra_environment_variables = merge(
      local.default_extra_environment_variables,
      var.service_override_extra_environment_variables
    )

    secrets = local.secrets

    file_upload_jobs = {
      for job_name, job_config in local.file_upload_jobs :
      # For job configs that don't define a source_bucket, add the source_bucket config property
      job_name => merge({ source_bucket = local.bucket_name }, job_config)
    }

    # Identity provider configuration
    enable_identity_provider = var.enable_identity_provider
    # Support local development against remote resources
    auth_callback_urls       = var.domain_name != null ? ["https://${var.domain_name}", "http://localhost:3000"] : ["http://localhost:3000"]
    logout_urls              = var.domain_name != null ? ["https://${var.domain_name}", "http://localhost:3000"] : ["http://localhost:3000"]
  }
}

output "storage_config" {
  value = {
    # Include project name in bucket name since buckets need to be globally unique across AWS
    bucket_name = local.bucket_name
  }
}

output "incident_management_service_integration" {
  value = var.has_incident_management_service ? {
    integration_url_param_name = "/monitoring/${var.app_name}/${var.environment}/incident-management-integration-url"
  } : null
}
