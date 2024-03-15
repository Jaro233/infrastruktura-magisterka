module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8.3"

  cluster_name                   = var.cluster_name
  cluster_endpoint_public_access = true

  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_identity_providers = {
    sts = {
      client_id = "sts.amazonaws.com"
    }
  }


  eks_managed_node_groups = {
    myapp-eks-nodegroup = {
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
      min_size     = var.node_min_capacity
      max_size     = var.node_max_capacity
      desired_size = var.node_desired_capacity

      instance_types = [var.instance_type]
      capacity_type  = "SPOT"

      key_name = var.key_name
    }
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

resource "aws_eks_access_entry" "access_entry" {
  cluster_name      = module.eks.cluster_name
  principal_arn     = var.iam_user_arn
  kubernetes_groups = ["group-1", "group-2"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "access_policy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.iam_user_arn

  access_scope {
    type = "cluster"
  }
}