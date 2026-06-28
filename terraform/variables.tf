variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "Goodness"
}

variable "db_name" {
  default = "drupal"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  sensitive = true
}

