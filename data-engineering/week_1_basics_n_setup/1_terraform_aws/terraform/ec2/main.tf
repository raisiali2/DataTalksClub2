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

resource "aws_security_group" "ec2-airflow-sg" {
  name        = "zocamp-ec2-airflow-sg"
  description = "allow inbound traffic"

  ingress {
    description = "8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # trafic entering the cloud
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  # means trafic leaving the from inside private network out of public internet, existing the cloud
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "ec2-airflow-sg"
  }

}

resource "aws_iam_role" "ec2_zocamp_role" {
  name        = "ec2_zocamp_role"
  description = "ec2_zocamp_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "policy_name_ref" {
  # name = "s3_read_zoomcamp_policy"
  name = "s3_read_policy_zoomcamps"

}

resource "aws_iam_role_policy_attachment" "ec2_s3_access" {
  role       = aws_iam_role.ec2_zocamp_role.name
  policy_arn = "${data.aws_iam_policy.policy_name_ref.arn}"

}

resource "aws_iam_instance_profile" "iam_instance_pro" {
  name = "iam_instance_pro"
  role = "${aws_iam_role.ec2_zocamp_role.name}"
}

resource "aws_instance" "application_server" {
  ami                    = "ami-05b457b541faec0ca"
  instance_type          = "t2.medium"
  count = 4
  vpc_security_group_ids = ["${aws_security_group.ec2-airflow-sg.id}"]        #aws_security_group.ec2-airflow-sg.arn]
#   iam_instance_proro   = "${aws_iam_instance_proile.iam_instance_pro.name}" #aws_iam_role.ec2_zocamp_role.name
  user_data              = <<EOF
    #! /bin/bash
    sudo apt -y update
    sudo apt -y install docker
    sudo usermod -a -G docker $USER
    id $USER
    newgrp docker
    sudo apt -y install python3-pip
    sudo pip3 install docker-compose
    sudo systemctl enable docker.service
    sudo systemctl start docker.service
    cd ..
    cd ..
    sudo mkdir airflow-docker
    sudo chmod a+rwx airflow-docker
    cd airflow-docker
    curl -Lf0 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml' --output docker-compose.yaml
    mkdir ./dags ./plugins ./logs
    touch .env
    echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=0" >  .env
    docker-compose up airflow-init
    docker-compose up
  EOF

  tags = {
    Name = var.instance_name
  }
}



