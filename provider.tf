provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  alias  = "eastside"
  region = "us-east-1"
}