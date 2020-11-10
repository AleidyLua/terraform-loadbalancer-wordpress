


   resource "aws_launch_template" "launch_template" {
     name = var.name
   image_id = var.image_id
   instance_type = var.instance_type
   key_name = var.key_name
   vpc_security_group_ids = [var.vpc_security_groups_ids]

   tag_specifications {
     resource_type = "instance"

     tags = {
       Deployment_Method = "Terraform"
       Name = "${var.app_name}-launch-template"
     }
   }
   }


