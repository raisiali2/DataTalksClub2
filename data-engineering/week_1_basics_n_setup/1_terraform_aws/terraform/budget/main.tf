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

resource "aws_budgets_budget" "monthly-budget" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "700"
  limit_unit        = "USD"
  time_period_start = "2023-02-27_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["user@example.com"]
  }
}