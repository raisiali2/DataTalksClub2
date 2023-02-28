terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-3"
}

resource "aws_s3_bucket" "Bucket1s3" {
  bucket = var.bucket_name_data
  acl    = "private"
  tags = {
    Name = "created using terraform"
  }

}

resource "aws_s3_bucket" "Bucket2s3" {
  bucket = var.bucket_name_dag
  acl    = "private"
  tags = {
    Name = "created using terraform"
  }

}


resource "aws_iam_policy" "rw_policy_bucket" {
  name        = "s3_rw_policy_zoomcamp"
  path        = "/"
  description = "Allow rw access to S3"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*"
        ]
      }
    ]
  })
}


resource "aws_iam_policy" "read_policy_bucket" {
  name        = "s3_read_policy_zoomcamps"
  path        = "/"
  description = "Allow read access to s3 "
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : ["s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*"
        ]
      }
    ]
  })
}

