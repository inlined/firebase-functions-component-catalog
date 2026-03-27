variable "extension_id" {
  description = "The extension ID, if this function is part of an extension."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the function. If extension_id is set, the actual function name will be 'ext-extension_id-name'."
  type        = string
}

variable "project_id" {
  description = "The project ID."
  type        = string
}

variable "region" {
  description = "The region to deploy the function to."
  type        = string
  default     = "us-central1"
}

variable "invokers" {
  description = "The invokers for the function."
  type        = set(string)
  default     = []
}

variable "firebase_admin_config" {
  description = "The standard Firebase Admin configuration."
  type        = any
  default     = null
}

variable "source_archive" {
  description = "The `gs://` URL of the source code ZIP archive."
  type        = string
  validation {
    condition     = can(regex("^gs://.*\\.(tgz|zip)$", var.source_archive))
    error_message = "The source_archive must be a gs:// URL ending with .tgz or .zip"
  }
}

variable "runtime" {
  description = "The runtime in which the function will run."
  type        = string
  default     = "nodejs22"
}

variable "description" {
  description = "The description of the function."
  type        = string
  default     = null
}

variable "available_memory_mb" {
  description = "The amount of memory in MB available for the function."
  type        = number
  default     = null
}

variable "timeout" {
  description = "The amount of time in seconds the function has to execute."
  type        = number
  default     = null
}

variable "environment_variables" {
  description = "A map of environment variables."
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "A map of labels."
  type        = map(string)
  default     = {}
}

variable "vpc_connector" {
  description = "The VPC Access Connector."
  type        = string
  default     = null
}

variable "vpc_connector_egress_settings" {
  description = "The VPC Access Connector egress settings."
  type        = string
  default     = null
}

variable "max_instances" {
  description = "The maximum number of instances for the function."
  type        = number
  default     = null
}

variable "min_instances" {
  description = "The minimum number of instances for the function."
  type        = number
  default     = null
}

variable "ingress_settings" {
  description = "The ingress settings for the function."
  type        = string
  default     = null
}

variable "service_account" {
  description = "The service account for the function. Can use a full email address or a name ending with @ for project-relative service accounts."
  type        = string
  default     = null
}

variable "secret_environment_variables" {
  description = "A list of secret environment variables."
  type        = list(object({
    key        = string
    secret     = string
    version    = string
  }))
  default     = []
}

variable "rate_limits_max_concurrent_dispatches" {
  description = "The maximum number of concurrent tasks that Cloud Tasks allows to be dispatched for this queue."
  type        = number
  default     = null
}

variable "rate_limits_max_dispatches_per_second" {
  description = "The maximum rate at which tasks are dispatched from this queue."
  type        = number
  default     = null
}

variable "retry_config_max_attempts" {
  description = "Number of attempts per task."
  type        = number
  default     = null
}

variable "retry_config_max_retry_duration" {
  description = "If positive, max_retry_duration specifies the time limit for retrying a failed task."
  type        = string
  default     = null
}

variable "retry_config_min_backoff" {
  description = "A task will be scheduled for retry between min_backoff and max_backoff duration after it fails."
  type        = string
  default     = null
}

variable "retry_config_max_backoff" {
  description = "A task will be scheduled for retry between min_backoff and max_backoff duration after it fails."
  type        = string
  default     = null
}

variable "retry_config_max_doublings" {
  description = "The time between retries will double max_doublings times."
  type        = number
  default     = null
}
