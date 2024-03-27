module "ecr" {
  source          = "terraform-aws-modules/ecr/aws"
  version         = "~> 1.6.0"
  repository_name = var.ecr_repo_name
  repository_read_write_access_arns = [var.iam_user_arn]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than 30 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

output "ecr_repository_url" {
  description = "URL of the repository."
  value       = module.ecr.repository_url
}
