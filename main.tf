module "iam" {
    source = "./modules/IAM"
  
}

module "vpc" {
    source = "./modules/VPC"
  
}
 
module "security_groups" {
    source = "./modules/security_groups"
    vpc_id = module.vpc.vpc_id
}

module "eks" {
    source = "./modules/eks"
    private_subnets = module.vpc.private_subnets
    security_group_ids = [module.security_groups.public_sg_id, module.security_groups.private_sg_id]
    eks_cluster_role_arn = module.iam.eks_cluster_role
    eks_node_role_arn = module.iam.eks_node_role

}