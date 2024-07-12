resource "aws_key_pair" "vpn" {
  key_name   = "minikube"
  public_key = file("~/.ssh/minikube.pub")
}

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-vpn"
  ami = data.aws_ami.openvpn.id
  instance_type          = "t3.micro"
  key_name = aws_key_pair.vpn.id
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id              = local.public_subnet_id
  tags = merge(
    var.common_tags,
    {
        Name="${var.project_name}-${var.environment}-vpn"
    }
  )
}

