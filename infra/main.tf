module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
  alb_dns_name = module.alb.lb_dns_name
  alb_zone_id  = module.alb.lb_zone_id
}

module "alb" {
  source             = "./modules/alb"
  certificate_arn    = module.acm.certificate_arn
  alb_security_group = module.security_groups.security_groups
  vpc_id             = module.vpc.vpc_id
  health_check_path  = var.health_check_path
  container_port     = var.container_port
  ssl_policy         = var.ssl_policy
  alb_name           = var.alb_name
  public_subnets     = module.vpc.public_subnets
}

module "ecs" {
  source           = "./modules/ecs"
  target_group_arn = module.alb.target_group_arn
  container_image  = var.container_image
  desired_count    = var.desired_count
  task_cpu         = var.task_cpu
  task_memory      = var.task_memory
  app_name         = var.app_name
  private_subnets  = module.vpc.private_subnets
  container_port   = var.container_port
  alb_listener_arn = module.alb.https_listener_arn
  security_group   = module.security_groups.security_groups
}

module "security_groups" {
  source                = "./modules/security groups"
  http_port             = var.http_port
  https_port            = var.https_port
  vpc_id                = module.vpc.vpc_id
  allowed_ingress_cidrs = var.allowed_ingress_cidrs
  allowed_egress_cidrs  = var.allowed_egress_cidrs
  app_port              = var.app_port
}

module "vpc" {
  source                = "./modules/vpc"
  public_subnet_a_cidr  = var.public_subnet_a_cidr
  public_subnet_b_cidr  = var.public_subnet_b_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
  az_a                  = var.az_a
  az_b                  = var.az_b
  project_name          = var.project_name
}