variable "application_name" {}

variable "application_healthckeck_url" {
  default = "/"
}

variable "aws_region" {}

variable "balancer_security_group_id" {}

variable "connection_draining_enabled" {}

variable "create_application" {
  default = "true"

  description = <<EOF
  If to create or not a Beanstalk application, valid values are true and false (as a string).
  If this value is false a Beanstalk application with this name must exist.
  EOF
}

variable "deployment_policy" {
  description = "Beanstalk deployment policy. Should be AllAtOnce, Rolling, RollingWithAdditionalBatch or Immutable"
}

variable "deployment_batch_size" {
  description = "Size of the deployment batch"
}

variable "deployment_batch_size_type" {
  description = "Type of batch size, Percentage or Fixed"
}

variable "enable_proxy_server" {
  default     = true
  description = "Enable Nginx proxy server for Docker environments"
}

variable "environment_create_timeout" {}

variable "environment_type" {
  description = "Type of Beanstalk environment, either LoadBalanced or SingleInstance"
  default     = "LoadBalanced"
}

variable "https_listener_enabled" {
  description = "Enables or disables the HTTPS listener"
}

variable "instance_security_group_id" {}

variable "instance_type" {}

variable "min_availability_zones" {
  description = "Minimum number of availability zones to deploy the app. Should be 1 or 2."
}

variable "min_instance_count" {}

variable "max_instance_count" {}

variable "rolling_update_enabled" {}

variable "rolling_update_max_batch_size" {}

variable "rolling_update_type" {}

variable "root_volume_size" {}

variable "scale_breach_duration" {
  description = "Amount of time that a metric is beyond the limit to trigger the scaling."
}

variable "scale_cooldown_seconds" {
  description = "Time required between two scale activities take place."
}

variable "scale_down_instances_to_remove" {}

variable "scale_lower_threshold" {
  description = "Maximum measurement to trigger scale down."
}

variable "scale_metric" {
  description = "Metric used for scaling, like CPUUtilization, NetworkIn"
}

variable "scale_monitoring_interval" {
  description = "Frequency (in minutes) of sending logs to AWS CloudWatch. Should be 1 or 5"
}

variable "scale_monitoring_period_in_minutes" {
  description = "Frequence that CloudWatch monitors the trigger metrics"
}

variable "scale_statistic" {
  description = "Statistic to use to scale, like Average, Sum."
}

variable "scale_unit" {
  description = "Unit to scale, like Bytes, Percent, Count"
}

variable "scale_up_instances_to_add" {}

variable "scale_upper_threshold" {
  description = "Minimum measurement to trigger scale up."
}

variable "solution_stack_name" {}

variable "ssh_key" {}

variable "ssl_certificate_arn" {}

variable "subnet_ids" {}

variable "vpc_id" {}
