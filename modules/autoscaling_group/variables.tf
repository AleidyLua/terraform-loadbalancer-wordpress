

variable "desired_capacity" {
  type = number
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "launch_template_id" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "target_group_arns" {
 type = list(string)
}