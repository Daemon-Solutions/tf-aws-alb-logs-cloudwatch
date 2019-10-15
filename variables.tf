variable "name" {
  description = "Name of the resources this module creates"
}

variable "log_group_name" {
  description = "Name of the log group to create the log stream in"
}

variable "log_stream_name" {
  description = "Name of the log stream to create"
}

variable "log_bucket_id" {
  description = "Name of the bucket to retrieve logs"
}

variable "log_retention" {
  description = "Log expiry time in days"
  default     = 60
}
