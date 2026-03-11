# Domain & DNS
domain_name = "abdelhakimyusuf.com"              

# VPC Module
 public_subnet_a_cidr  = "10.0.1.0/24"  
public_subnet_b_cidr  = "10.0.2.0/24"  
private_subnet_a_cidr = "10.0.11.0/24" 
private_subnet_b_cidr = "10.0.12.0/24" 
az_a                  = "eu-west-2a"
az_b                  = "eu-west-2b"

# ECS Module
app_name        = "value"
task_cpu        = 1024
task_memory     = 2048
container_port  = 8080
container_image = "992382674979.dkr.ecr.eu-west-2.amazonaws.com/code-server:latest"
desired_count   = 3

# ALB Module
alb_name           = "code-server"
health_check_path  = "/login"
ssl_policy         = "ELBSecurityPolicy-2016-08"


# Security Group Module
project_name          = "code-server"
allowed_ingress_cidrs = ["0.0.0.0/0"]
allowed_egress_cidrs  = ["0.0.0.0/0"]
app_port              = "8080"
http_port             = "80"
https_port            = "443"
