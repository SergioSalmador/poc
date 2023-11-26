module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-eks-tf"
  cluster_version = "1.28"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  iam_role_additional_policies = {
    ec2full = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  }

  cluster_addons = {
    kube-proxy = {}
    vpc-cni    = {}
    coredns    = {}
  }

  eks_managed_node_groups = {
    eks-node-1 = {
      desired_size   = 4
      min_size       = 2
      max_size       = 4
      instance_types = ["t2.micro"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

}
