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


resource "aws_iam_role" "zoomcamp_redshift_role_aws" {
  name        = "zoomcamp_redshift_role_aws"
  description = "zoomcamp_redshift_role_aws"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      },
    ]
  })
}


# Confuge security group for Redshift allowing all inbound/outbound traffic
resource "aws_security_group" "sg_redshift_aws" {
  name = "sg_redshift_aws"
  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



data "aws_iam_policy" "policy_name_ref" {
  name = "s3_rw_policy_zoomcamp"
}

resource "aws_iam_role_policy_attachment" "S3_redshift_aws" {
  role       = aws_iam_role.zoomcamp_redshift_role_aws.name
  policy_arn = data.aws_iam_policy.policy_name_ref.arn
}

resource "aws_redshift_cluster" "redshift" {
  cluster_identifier     = "my-sample-cluster"
  database_name          = "sample_db"
  master_username        = var.username
  master_password        = var.password
  node_type              = "dc2.large"
  cluster_type           = "single-node"
  skip_final_snapshot    = true
  iam_roles              = [aws_iam_role.zoomcamp_redshift_role_aws.arn]
  vpc_security_group_ids = [aws_security_group.sg_redshift_aws.id]
}

