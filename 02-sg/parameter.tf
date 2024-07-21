resource "aws_ssm_parameter" "db_sg_id" {
  name  = "/${var.project_name}/${var.environment}/db_sg_id"
  type  = "String"
  value = module.db.Sg_id
}

resource "aws_ssm_parameter" "backend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/backend_sg_id"
  type  = "String"
  value = module.backend.Sg_id
}

resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/frontend_sg_id"
  type  = "String"
  value = module.frontend.Sg_id
}

resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project_name}/${var.environment}/bastion_sg_id"
  type  = "String"
  value = module.bastion.Sg_id
}

resource "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/${var.project_name}/${var.environment}/vpn_sg_id"
  type  = "String"
  value = module.vpn.Sg_id
}

resource "aws_ssm_parameter" "app_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/app_alb_sg_id"
  type  = "String"
  value = module.app_alb.Sg_id
}


resource "aws_ssm_parameter" "web_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/web_alb_sg_id"
  type  = "String"
  value = module.web_alb.Sg_id
}

