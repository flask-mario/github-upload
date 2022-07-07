/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:ap-northeast-1:027500179340:environment/app1-pre-env

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

locals {
  name            = var.environment.inputs.cluster_name
  region          = data.aws_region.current.name
  cluster_version = var.environment.inputs.kubernetes_version
  #terraform_version = "Terraform v1.0.1"

  vpc_cidr      = var.environment.inputs.vpc_cidr
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