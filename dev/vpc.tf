# This is where you call the vpc module.
module "vpc" {
  source               = "../modules/vpc"
  app_name             = var.app_name
  vpc_cidr_block       = "10.200.0.0/16"
  region               = var.region
  public_subnet1_cidr_block = "10.200.0.0/24"
  public_subnet2_cidr_block = "10.200.1.0/24"
}
module "security_group1" {
  source = "../modules/security_group"
  app_name = var.app_name
  vpc_id = module.vpc.vpc_id
  security_group_name = "public"
  ingress_rules = [
    {
      description = "All traffic on port 22"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }]
  egress_rules = [
    {
      description = ""
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_block = "0.0.0.0/0"
    }]

}
module "security_group2" {
  source = "../modules/security_group"
  app_name = var.app_name
  vpc_id = module.vpc.vpc_id
  security_group_name = "private"
  sg_ingress_rules = [
    {
      description = "Allow traffic from public instances.security_group"
      from_port = 0
      to_port = 0
      protocol = "-1"
      security_groups = [module.security_group1.security_group_id]
    }]
  egress_rules = [
    {
      description = ""
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_block = "0.0.0.0/0"
    }]

}
