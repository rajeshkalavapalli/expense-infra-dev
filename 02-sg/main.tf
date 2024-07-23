module "db" {
  source = "../../expense-terraform-sg"
  project_name = var.project_name
  sg_description = var.sg_description
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "db"

}

module "backend" {
  source = "../../expense-terraform-sg"
  project_name = var.project_name
  sg_description = "sg for backend"
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "backend"

}

module "frontend" {
  source = "../../expense-terraform-sg"
  project_name = var.project_name
  sg_description = "sg for frontend"
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "fronend"

}

module "web_alb" {
  source = "../../expense-terraform-sg"
  project_name = var.project_name
  sg_description = "sg for web alb "
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "web-alb"

}

module "bastion" {
  source = "../../expense-terraform-sg"
  project_name = var.project_name
  sg_description = "sg for bastion"
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "bastion"

}

module "app_alb" {
  source = "../../expense-terraform-sg"
  project_name = var.project_name
  sg_description = "sg for alb"
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "app_alb"

}
module "vpn" {
  source = "../../expense-terraform-sg"
  project_name = var.project_name
  sg_description = "sg for vpn"
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "vpn"
  inbound_rules = var.vpn_sg_rules

}


# db is accepting connection from backend 
resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend.Sg_id
  security_group_id = module.db.Sg_id
}

# db is accepting connection from backend 
resource "aws_security_group_rule" "db_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion.Sg_id
  security_group_id = module.db.Sg_id
}

# db is accepting connection from vpn
resource "aws_security_group_rule" "db_vpn" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.vpn.Sg_id
  security_group_id = module.db.Sg_id
}



#backend is accepting connection from app_alb 
resource "aws_security_group_rule" "backend_app_alb" {  
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb.Sg_id # from where it accepting 
  security_group_id = module.backend.Sg_id # what we creating 
} 

#backend is accepting connection from frontend
resource "aws_security_group_rule" "app_alb_frontend" {  
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend.Sg_id # from where it accepting 
  security_group_id = module.app_alb.Sg_id # what we creating 
} 

#backend is accepting connection from app_alb 
resource "aws_security_group_rule" "app_alb_vpn" {  
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.Sg_id # from where it accepting 
  security_group_id = module.app_alb.Sg_id # what we creating 
} 
#backend is accepting connection from vpn 
resource "aws_security_group_rule" "backend_vpn_ssh" {  
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.Sg_id # from where it accepting 
  security_group_id = module.backend.Sg_id # what we creating 
} 

#backend is accepting connection from vpn 
resource "aws_security_group_rule" "backend_vpn_http" {  
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.Sg_id # from where it accepting 
  security_group_id = module.backend.Sg_id # what we creating 
} 



#backend is accepting connection from bastion 
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.Sg_id # from where it accepting 
  security_group_id = module.backend.Sg_id # what we creating 
} 


#backend is accepting connection from pubic 
resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp" 
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend.Sg_id # what we creating 
}

#backend is accepting connection from pubic 
resource "aws_security_group_rule" "web_alb_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp" 
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_alb.Sg_id # what we creating 
} 
#backend is accepting connection from pubic 
resource "aws_security_group_rule" "web_alb_public_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp" 
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_alb.Sg_id # what we creating 
} 
#backend is accepting connection from bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp" 
  source_security_group_id = module.bastion.Sg_id # from where it accepting 
  security_group_id = module.frontend.Sg_id # what we creating 
}



#bastion is accepting connection from public
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp" 
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion.Sg_id # what we creating 
} 


#part of jenkins cicd
resource "aws_security_group_rule" "backend_default_vpc" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp" 
  cidr_blocks = ["172.31.0.0/16"]
  security_group_id = module.backend.Sg_id # what we creating 
} 

#web accepting connection from public
resource "aws_security_group_rule" "web_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp" 
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend.Sg_id # what we creating 
} 