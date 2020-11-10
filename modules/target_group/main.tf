resource "aws_lb_target_group" "test" {
  name     = "test"
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc


health_check {
 enabled           = true
 matcher           = "200-304"
 protocol          = "HTTP"
 path              = var.health_check_path
 timeout           = 30
 interval          = 31
 healthy_threshold = 2
}

}





