variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_profile" {
  default = "default"
}

variable "allowed_cidr" {
  type = list(string)
  default = ["77.105.178.135/32", "109.106.142.117/32", "213.87.128.194/32"]
}