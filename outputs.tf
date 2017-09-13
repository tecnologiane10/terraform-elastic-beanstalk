output "deployment_bucket" {
  value = "${aws_s3_bucket.beanstalk_deploy.bucket}"
}

output "deployment_bucket_arn" {
  value = "${aws_s3_bucket.beanstalk_deploy.arn}"
}

output "instance_role_id" {
  value = "${aws_iam_role.instance_role.id}"
}

output "endpoint" {
  value = "${aws_elastic_beanstalk_environment.main.cname}"
}
