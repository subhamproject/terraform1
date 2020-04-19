terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "terraform-subham1"
    key            = "terraform.tfstate"
    encrypt        = true #AES-256 encryptio"
    dynamodb_table = "terraform-state-lock"
  }
}
