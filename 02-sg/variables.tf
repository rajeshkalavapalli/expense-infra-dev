variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "sg_name" {
  default = {}
}

variable "sg_description" {
  default = "allowing sg for mysql "
}

variable "common_tags" {
   default = {
    project_name="expense"
    environment="dev"
    terraform= true
  }
}

variable "vpn_sg_rules" {
  default = [
    {
      description = "HTTPS ingress"
      from_port   = 943
      to_port     = 943
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS ingress"
      from_port   = 1194
      to_port     = 1194
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
