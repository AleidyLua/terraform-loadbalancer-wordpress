resource "aws_instance" "ec2-instance" {
  ami           = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [
  var.security_group_id]
  subnet_id                   = var.subnet
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name       = var.instance_name
    created_by = var.created_by
    fav_food   = var.fav_food
    fav_movie = var.fav_movie
    fav_drink = var.fav_drink
  }
}



