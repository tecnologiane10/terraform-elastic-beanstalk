resource "aws_elastic_beanstalk_application" "main" {
  count = "${var.create_application ? 1 : 0}"
  name  = "${var.application_name}"
}

resource "aws_elastic_beanstalk_environment" "main" {
  application            = "${length(var.beanstalk_application_name) == 0 ? var.application_name : var.beanstalk_application_name}"
  name                   = "${length(var.beanstalk_application_name) == 0 ? var.application_name : var.beanstalk_application_name}"
  solution_stack_name    = "${var.solution_stack_name}"
  wait_for_ready_timeout = "${var.environment_create_timeout}"

  # aws:autoscaling:asg
  setting {
    name      = "Availability Zones"
    namespace = "aws:autoscaling:asg"
    value     = "Any ${var.min_availability_zones}"
  }

  setting {
    name      = "Cooldown"
    namespace = "aws:autoscaling:asg"
    value     = "${var.scale_cooldown_seconds}"
  }

  setting {
    name      = "MinSize"
    namespace = "aws:autoscaling:asg"
    value     = "${var.min_instance_count}"
  }

  setting {
    name      = "MaxSize"
    namespace = "aws:autoscaling:asg"
    value     = "${var.max_instance_count}"
  }

  # aws:autoscaling:launchconfiguration
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "${var.ssh_key}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.instance_profile.name}"
  }

  setting {
    name      = "InstanceType"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "${var.instance_type}"
  }

  setting {
    name      = "MonitoringInterval"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "${var.scale_monitoring_interval} minute"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${var.instance_security_group_id}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeSize"
    value     = "${var.root_volume_size}"
  }

  # aws:autoscaling:scheduledaction
  # aws:autoscaling:trigger
  setting {
    name      = "BreachDuration"
    namespace = "aws:autoscaling:trigger"
    value     = "${var.scale_breach_duration}"
  }

  setting {
    name      = "LowerBreachScaleIncrement"
    namespace = "aws:autoscaling:trigger"
    value     = "-${var.scale_down_instances_to_remove}"
  }

  setting {
    name      = "LowerThreshold"
    namespace = "aws:autoscaling:trigger"
    value     = "${var.scale_lower_threshold}"
  }

  setting {
    name      = "MeasureName"
    namespace = "aws:autoscaling:trigger"
    value     = "${var.scale_metric}"
  }

  setting {
    name      = "Period"
    namespace = "aws:autoscaling:trigger"
    value     = "${var.scale_monitoring_period_in_minutes}"
  }

  setting {
    name      = "Statistic"
    namespace = "aws:autoscaling:trigger"
    value     = "${var.scale_statistic}"
  }

  setting {
    name      = "Unit"
    namespace = "aws:autoscaling:trigger"
    value     = "${var.scale_unit}"
  }

  setting {
    name      = "UpperBreachScaleIncrement"
    namespace = "aws:autoscaling:trigger"
    value     = "${var.scale_up_instances_to_add}"
  }

  setting {
    name      = "UpperThreshold"
    namespace = "aws:autoscaling:trigger"
    value     = "${var.scale_upper_threshold}"
  }

  # aws:autoscaling:updatepolicy:rollingupdate
  setting {
    name      = "MaxBatchSize"
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    value     = "${var.rolling_update_max_batch_size}"
  }

  setting {
    name      = "RollingUpdateEnabled"
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    value     = "${var.rolling_update_enabled}"
  }

  setting {
    name      = "RollingUpdateType"
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    value     = "${var.rolling_update_type}"
  }

  # aws:ec2:vpc
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${join(",", sort(split(",", var.subnet_ids)))}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.vpc_id}"
  }

  # aws:elasticbeanstalk:application
  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "${var.application_healthckeck_url}"
  }

  # aws:elasticbeanstalk:command
  setting {
    name      = "DeploymentPolicy"
    namespace = "aws:elasticbeanstalk:command"
    value     = "${var.deployment_policy}"
  }

  setting {
    name      = "BatchSizeType"
    namespace = "aws:elasticbeanstalk:command"
    value     = "${var.deployment_batch_size_type}"
  }

  setting {
    name      = "BatchSize"
    namespace = "aws:elasticbeanstalk:command"
    value     = "${var.deployment_batch_size}"
  }

  # aws:elasticbeanstalk:environment
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "${var.environment_type}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "${aws_iam_role.beanstalk_service_role.name}"
  }

  # aws:elasticbeanstalk:environment:process:process_name
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = "${var.application_healthckeck_url}"
  }

  # aws:elasticbeanstalk:healthreporting:system
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  # aws:elbv2:loadbalancer
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = "${var.balancer_security_group_id}"
  }

  # aws:elbv2:listener:443
  setting {
    name      = "ListenerEnabled"
    namespace = "aws:elbv2:listener:443"
    value     = "${var.https_listener_enabled}"
  }

  setting {
    name      = "Protocol"
    namespace = "aws:elbv2:listener:443"
    value     = "HTTPS"
  }

  setting {
    name      = "SSLCertificateArns"
    namespace = "aws:elbv2:listener:443"
    value     = "${var.ssl_certificate_arn}"
  }

  setting {
    name      = "ProxyServer"
    namespace = "aws:elasticbeanstalk:environment:proxy"
    value     = "${var.enable_proxy_server ? "nginx" : "none"}"
  }
}

resource "aws_security_group_rule" "balancer_http_inbound" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "80"
  protocol          = "tcp"
  security_group_id = "${var.balancer_security_group_id}"
  to_port           = "80"
  type              = "ingress"
}

resource "aws_security_group_rule" "balancer_https_inbound" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "443"
  protocol          = "tcp"
  security_group_id = "${var.balancer_security_group_id}"
  to_port           = "443"
  type              = "ingress"
}
