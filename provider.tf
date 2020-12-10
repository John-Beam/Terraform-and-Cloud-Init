variable "region" {
  default = "croc"
}

provider "aws" {
  endpoints {
    ec2 = "https://api.cloud.croc.ru"
      }



  # NOTE: STS API is not implemented, skip validation
  skip_credentials_validation = true

  # NOTE: IAM API is not implemented, skip validation
  skip_requesting_account_id = true

  # NOTE: Region has different name, skip validation
  skip_region_validation = true

  access_key = var.c2_access_key
  secret_key = var.c2_secret_key
  region     = var.region
}
