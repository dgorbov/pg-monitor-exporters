terraform {
  backend "s3" {
    bucket         = "pg-monitor-exporters-tf-state"
    key            = "terraform/main-state"
    dynamodb_table = "tf-state-lock-pg-monitor-exporters-tf-state"
  }
}