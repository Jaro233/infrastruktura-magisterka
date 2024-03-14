vpc_name              = "myapp-vpc"
vpc_cidr              = "172.16.0.0/16"
azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets       = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
public_subnets        = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
environment           = "dev"
cluster_name          = "myapp-eks-cluster"
node_group            = "myapp-eks-nodegroup"
node_desired_capacity = 2
node_max_capacity     = 3
node_min_capacity     = 1
instance_type         = "t2.large"
key_name              = "ec2_apache"
region                = "us-east-1"
ecr_repo_name = "my-ecr"
iam_user_arn = "arn:aws:iam::941391622677:user/eks-admin"