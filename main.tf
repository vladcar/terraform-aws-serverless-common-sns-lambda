data "aws_region" "current" {}
data "aws_caller_identity" "identity" {}

module "lambda" {
  source                       = "terraform-aws-modules/lambda/aws"
  function_name                = var.function_name
  handler                      = var.handler
  runtime                      = var.runtime
  publish                      = false
  layers                       = var.layers
  timeout                      = 30
  create_async_event_config    = true
  maximum_event_age_in_seconds = 120
  maximum_retry_attempts       = 0
  environment_variables        = var.env_vars
  policies                     = var.attached_policies

  #todo check this out
  create_package         = false
  local_existing_package = var.file_name

  allowed_triggers = {
    SnsTrigger = {
      service = "sns"
      arn     = var.sns_topic_arn
    }
  }
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = var.sns_topic_arn
  protocol  = "lambda"
  endpoint  = module.lambda.this_lambda_function_arn
}
