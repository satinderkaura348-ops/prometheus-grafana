#infra/backend.tf
terraform {
  backend "s3" {
    bucket         = "my-s3-monitoring-bucket-420"
    key            = "dev/infra/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "monitoring-DB"
    encrypt        = true
    }
}