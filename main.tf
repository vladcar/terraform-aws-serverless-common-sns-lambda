
module "lambda" {
  source                         = "vladcar/serverless-common-basic-lambda/aws"
  source_path                    = var.source_path
  function_name                  = var.function_name
  handler                        = var.handler
  memory_size                    = var.memory_size
  description                    = var.description
  reserved_concurrent_executions = var.reserved_concurrent_executions
  timeout                        = var.timeout
  create_async_invoke_config     = var.create_async_invoke_config
  maximum_event_age_in_seconds   = var.maximum_event_age_in_seconds
  maximum_retry_attempts         = var.maximum_retry_attempts
  destination_on_failure         = var.destination_on_failure
  destination_on_success         = var.destination_on_success
  runtime                        = var.runtime
  layers                         = var.layers
  env_vars                       = var.env_vars
  tags                           = var.tags
  create_role                    = var.create_role
  execution_role                 = var.execution_role
  attached_policies              = var.attached_policies
}

resource "aws_lambda_permission" "sns_lambda" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn
}

resource "aws_sns_topic_subscription" "new_prospect_approval_subscription" {
  topic_arn = var.sns_topic_arn
  protocol  = "lambda"
  endpoint  = module.lambda.lambda_arn
}
