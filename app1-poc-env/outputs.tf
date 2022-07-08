/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:ap-northeast-1:027500179340:environment/app1-poc-env

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

#output "vpc_id" {
#  description = "The ID of the VPC"
#  value       = module.vpc.vpc_id
#}
#output "private_subnets" {
#  description = "List of IDs of private subnets"
#  value       = module.vpc.private_subnets
#}

#output "public_subnets" {
#  description = "List of IDs of public subnets"
#  value       = module.vpc.public_subnets
#}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = module.eks_blueprints.configure_kubectl
}

output "team_riker" {
  description = "Role Arn of team-riker"
  value       = module.eks_blueprints.teams[*].application_teams_iam_role_arn["team-riker"]
}

output "platform_team" {
  description = "Role Arn of platform-team"
  value       = module.eks_blueprints.teams[*].platform_teams_iam_role_arn["admin"]
}

output "platform_teams_configure_kubectl" {
  description = "The command to use to configure the kubeconfig file to be used with kubectl."
  value = tomap({
    for k, v in module.eks_blueprints.teams[0].platform_teams_iam_role_arn : k => "aws eks --region ${data.aws_region.current.id} update-kubeconfig --name ${module.eks_blueprints.cluster_name}  --role-arn ${v}"
  })["platform-team"]
}
