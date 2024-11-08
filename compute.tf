module "ec2_private" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "2.17.0"

  name                   = "alloy-vm-${var.environment}"
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [module.private_sg.security_group_id]

  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]

  instance_count = 2
  user_data      = file("${path.module}/create-service.sh")
  tags           = local.tags
}

module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  name                   = "alloy-bastion-${var.environment}"
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags                   = local.tags
}

module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "public-bastion-sg"
  description = "ssh in open, all outbound open"
  vpc_id      = module.vpc.vpc_id

  # Ingress
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress
  egress_rules = ["all-all"]
  tags         = local.tags
}

module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "private-sg"
  description = "ingress only for ips from vpc block"
  vpc_id      = module.vpc.vpc_id
  
  # Ingress
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "http-8080-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  
  # Egress
  egress_rules = ["all-all"]
  tags         = local.tags
}
