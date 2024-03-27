terraform {
  # backend "s3" {
  #   bucket = "magisterka-infra-bucket"
  #   key    = "terraform/backend.tfstate"
  #   region = "us-east-1"
  # }
  cloud { 
    organization = "jaro233" 
    workspaces { 
      name = "my-workspace" 
      } 
    }
}
