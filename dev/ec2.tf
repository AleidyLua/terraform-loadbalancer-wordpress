//# This is where you call the ec2 module.
//module "ec2-1" {
//  source            = "../modules/ec2"
//  app_name          = var.app_name
//  image_id          = "ami-0947d2ba12ee1ff75"
//  subnet            = module.vpc.subnet_id1
//  instance_type     = "t2.micro"
//  instance_name     = "public_instance1"
//  key_name          = "ale-us-east-1"
//  name              = "1"
//  created_by        = "Aleidy"
//  fav_food          = "pizza"
//  fav_movie         = "nemo"
//  fav_drink         = "pepsi"
//  security_group_id = module.security_group1.security_group_id
//}
//module "ec2-2" {
//  source            = "../modules/ec2"
//  app_name          = var.app_name
//  image_id          = "ami-0947d2ba12ee1ff75"
//  subnet            = module.vpc.subnet_id2
//  instance_type     = "t2.micro"
//  instance_name     = "public_instance2"
//  key_name          = "ale-us-east-1"
//  name              = "2"
//  created_by        = "Aleidy"
//  fav_food          = "pizza"
//  fav_movie         = "nemo"
//  fav_drink         = "pepsi"
//  security_group_id = module.security_group1.security_group_id
//}
//
//module "ec2-private" {
//  source            = "../modules/ec2"
//  app_name          = var.app_name
//  image_id          = "ami-0947d2ba12ee1ff75"
//  subnet            = module.vpc.private_subnet_id
//  instance_type     = "t2.micro"
//  instance_name     = "private_instance3"
//  key_name          = "ale-us-east-1"
//  name              = "3"
//  created_by        = "Aleidy"
//  fav_food          = "pizza"
//  fav_movie         = "nemo"
//  fav_drink         = "pepsi"
//  security_group_id = module.security_group2.security_group_id
//}
//









module "launch-template" {
  source = "../modules/launch_template"
  name = "template"
  image_id = "ami-0a76dc8792b2b167b"
  instance_type = "t2.micro"
  key_name = "ale-us-east-1"
  vpc_security_groups_ids = module.security_group1.security_group_id

  app_name = ""

}



module "ASG" {
  source = "../modules/autoscaling_group"
  subnet_id = module.vpc.subnet_id1
  target_group_arns = [module.target-group-1.target_group_arn]
  desired_capacity = 1
  max_size = 1
  min_size = 1
  launch_template_id = module.launch-template.launch_template_id

}


module "target-group-1" {
  source = "../modules/target_group"
  target_group_name = "test"
  vpc = module.vpc.vpc_id
}


module "ALB-stack" {
  source = "../modules/load_balancer"
  domain = "aleidy.kiastests.com"
  load_balancer_name = ""
  security_groups = [module.security_group1.security_group_id]
  subnets = [module.vpc.subnet_id1,module.vpc.subnet_id2]
  target_group_arn = module.target-group-1.target_group_arn
}
