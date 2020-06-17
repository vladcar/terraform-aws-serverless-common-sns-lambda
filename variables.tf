
variable "file_name" {
  type = string
}

variable "function_name" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "memory_size" {
  type = number
}

variable "attached_policies" {
  type        = list(string)
  default     = []
  description = "A list of IAM policy ARNs. Will be attached to execution role"
}

variable "sns_topic_arn" {
  type        = string
  description = "SNS topic ARN"
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "Lambda layer ARNs"
}

variable "env_vars" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}
