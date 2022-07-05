locals {
  name            = basename(path.cwd)
  region          = data.aws_region.current.name
  cluster_version = "1.21"
  #terraform_version = "Terraform v1.0.1"

  vpc_cidr      = "10.0.0.0/16"
  azs           = slice(data.aws_availability_zones.available.names, 0, 3)


  #---------------------------------------------------------------
  # ARGOCD ADD-ON APPLICATION
  #---------------------------------------------------------------

  addon_application = {
    path               = "chart"
    repo_url           = "https://github.com/flask-mario/eks-blueprints-add-ons.git"
    add_on_application = true
  }

  #---------------------------------------------------------------
  # ARGOCD WORKLOAD APPLICATION
  #---------------------------------------------------------------

  workload_application = {
    path               = "envs/dev"
    repo_url           = "https://github.com/flask-mario/eks-blueprints-workloads.git"
    add_on_application = false
  }

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints"
  }
}