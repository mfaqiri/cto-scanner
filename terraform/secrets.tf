locals {
  name_prefix = "prowler-api"
  prowler_api_env_variables = [
    "POSTGRES_HOST",
    "POSTGRES_PORT",
    "POSTGRES_ADMIN_USER" ,
    "POSTGRES_ADMIN_PASSWORD" ,
    "POSTGRES_USER" ,
    "POSTGRES_PASSWORD" ,
    "POSTGRES_DB" ,
    # Valkey settings
    "VALKEY_HOST",
    "VALKEY_PORT" ,
    "VALKEY_DB"  ,
    # Django settings
    "DJANGO_ALLOWED_HOSTS" ,
    "DJANGO_BIND_ADDRESS" ,
    "DJANGO_PORT" ,
    "DJANGO_DEBUG" ,
    "DJANGO_SETTINGS_MODULE" ,
    # Select one of [ndjson|human_readable]
    "DJANGO_LOGGING_FORMATTER" ,
    # Select one of [DEBUG|INFO|WARNING|ERROR|CRITICAL]
    # Applies to both Django and Celery Workers
    "DJANGO_LOGGING_LEVEL" ,
    # Defaults to the maximum available based on CPU cores if not set.
    "DJANGO_WORKERS" ,
    # Token lifetime is in minutes
    "DJANGO_ACCESS_TOKEN_LIFETIME" ,
    # Token lifetime is in minutes
    "DJANGO_REFRESH_TOKEN_LIFETIME" ,
    "DJANGO_CACHE_MAX_AGE" ,
    "DJANGO_STALE_WHILE_REVALIDATE" ,
    "DJANGO_MANAGE_DB_PARTITIONS" ,
    # openssl genrsa -out private.pem 2048
    "DJANGO_TOKEN_SIGNING_KEY" ,
    # openssl rsa -in private.pem -pubout -out public.pem
    "DJANGO_TOKEN_VERIFYING_KEY" ,
    # openssl rand -base64 32
    "DJANGO_SECRETS_ENCRYPTION_KEY" ,
    "DJANGO_BROKER_VISIBILITY_TIMEOUT" 
  ]
  prowler_ui_env_variables = [
    "PROWLER_UI_VERSION",
    "AUTH_URL",
    "API_BASE_URL",
    "NEXT_PUBLIC_API_DOCS_URL",
    "AUTH_TRUST_HOST",
    "UI_PORT",
    # openssl rand -base64 32
    "AUTH_SECRET"
  ]
}

resource "aws_secretsmanager_secret" "prowler_secret" {
  name = "${local.name_prefix}/env"
}

resource "aws_secretsmanager_secret_version" "prowler_secret_version" {
  secret_id = aws_secretsmanager_secret.prowler_secret.id
  secret_string = jsonencode({
    for key in local.prowler_api_env_variables : key => ""
  })
  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret" "prowler_ui_secret" {
  name = "prowler-ui/env"
}

resource "aws_secretsmanager_secret_version" "prowler_ui_secret_version" {
  secret_id = aws_secretsmanager_secret.prowler_ui_secret.id
  secret_string = jsonencode({
    for key in local.prowler_ui_env_variables : key => ""
  })
  lifecycle {
    ignore_changes = [secret_string]
  }
}