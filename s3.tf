resource "aws_s3_bucket" "beanstalk_deploy" {
  bucket = "${var.environment_name}-deploy"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags {
    Name = "${var.environment_name}-deploy"
  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = "${aws_s3_bucket.beanstalk_deploy.bucket}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.instance_role.arn}"
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.beanstalk_deploy.arn}/resources/environments/logs/*"
    },
    {
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:DeleteBucket",
      "Resource": "${aws_s3_bucket.beanstalk_deploy.arn}"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${aws_iam_role.instance_role.arn}"
        ]
      },
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "${aws_s3_bucket.beanstalk_deploy.arn}",
        "${aws_s3_bucket.beanstalk_deploy.arn}/resources/environments/*"
      ]
    }
  ]
}
EOF
}
