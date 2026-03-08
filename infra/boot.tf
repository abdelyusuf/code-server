# VPC & Networking
# resource "aws_vpc" "this" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true
#   tags = {
#     Name = "code-server"
#   }
# }
# ## Public Subnets
# resource "aws_subnet" "public_a" {
#   vpc_id                  = aws_vpc.this.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = "eu-west-2a"
#   map_public_ip_on_launch = true
# }

# resource "aws_subnet" "public_b" {
#   vpc_id                  = aws_vpc.this.id
#   cidr_block              = "10.0.2.0/24"
#   availability_zone       = "eu-west-2b"
#   map_public_ip_on_launch = true
# }

# ## Private Subnets
# resource "aws_subnet" "private_a" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "10.0.11.0/24"
#   availability_zone = "eu-west-2a"
# }

# resource "aws_subnet" "private_b" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "10.0.12.0/24"
#   availability_zone = "eu-west-2b"
# }

# resource "aws_internet_gateway" "this" {
#   vpc_id = aws_vpc.this.id
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.this.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.this.id
#   }
# }

# resource "aws_route_table_association" "public_a" {
#   subnet_id      = aws_subnet.public_a.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table_association" "public_b" {
#   subnet_id      = aws_subnet.public_b.id
#   route_table_id = aws_route_table.public.id
# }

## NAT Gateway for Private Subnets
# resource "aws_eip" "nat" {
#   domain = "vpc"
# }

# resource "aws_nat_gateway" "this" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public_a.id
# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.this.id
#   }
# }

# resource "aws_route_table_association" "private_a" {
#   subnet_id      = aws_subnet.private_a.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_route_table_association" "private_b" {
#   subnet_id      = aws_subnet.private_b.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_default_security_group" "this" {
#   vpc_id = aws_vpc.this.id

#   ingress {
#     protocol    = "tcp"
#     from_port   = 80
#     to_port     = 80
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     protocol    = "tcp"
#     from_port   = 443
#     to_port     = 443
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     protocol    = "tcp"
#     from_port   = 8080
#     to_port     = 8080
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # ECR
# resource "aws_ecr_repository" "this" {
#   name = "code-server"
# }

# # ECS Cluster
# resource "aws_ecs_cluster" "this" {
#   name = "code-server"

#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }
# }

# # IAM Role for ECS Task Execution
# resource "aws_iam_role" "ecs_task_execution_role" {
#   name = "ecsTaskExecutionRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ecs-tasks.amazonaws.com"
#       }
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# # ECS Task Definition
# resource "aws_ecs_task_definition" "this" {
#   family                   = "code-server"
#   requires_compatibilities = ["FARGATE"]
#   network_mode             = "awsvpc"
#   cpu                      = 1024
#   memory                   = 2048
#   execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

#   container_definitions = <<TASK_DEFINITION
# [
#  {
#   "name": "code-server",
#   "image": "992382674979.dkr.ecr.eu-west-2.amazonaws.com/code-server@sha256:9ac023eecb0911d0382dedb34f2405a79d434cff29f7d8bf6d046a7cd2eaea77",
#   "portMappings": [
#     {
#       "containerPort": 8080,
#       "protocol": "tcp"
#     }
#   ],
#   "essential": true,
#   "logConfiguration": {
#     "logDriver": "awslogs",
#     "options": {
#       "awslogs-group": "/ecs/code-server",
#       "awslogs-create-group": "true",
#       "awslogs-region": "eu-west-2",
#       "awslogs-stream-prefix": "ecs"
#     }
#   }
#  }
# ]
# TASK_DEFINITION

#   runtime_platform {
#     operating_system_family = "LINUX"
#     cpu_architecture        = "ARM64"
#   }
# }

# ALB
# resource "aws_lb" "this" {
#   name               = "code-server"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_default_security_group.this.id]

#   subnets = [
#     aws_subnet.public_a.id,
#     aws_subnet.public_b.id
#   ]

#   enable_deletion_protection = false
# }

# # ALB Target Group
# resource "aws_lb_target_group" "this" {
#   name        = "code-server"
#   port        = 8080
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.this.id
#   target_type = "ip"

#   health_check {
#     path                = "/login"
#     matcher             = "200-399"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     protocol            = "HTTP"
#   }
# }

# # HTTP Listener (Redirect to HTTPS)
# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.this.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

# # HTTPS Listener
# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.this.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate_validation.this.certificate_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.this.arn
#   }
# }

# # ECS Service
# resource "aws_ecs_service" "this" {
#   name            = "code-server"
#   cluster         = aws_ecs_cluster.this.id
#   task_definition = aws_ecs_task_definition.this.arn
#   desired_count   = 3
#   launch_type     = "FARGATE"

#   load_balancer {
#     target_group_arn = aws_lb_target_group.this.arn
#     container_name   = "code-server"
#     container_port   = 8080
#   }

#   network_configuration {
#     subnets          = [aws_subnet.private_a.id, aws_subnet.private_b.id]
#     security_groups  = [aws_default_security_group.this.id]
#     assign_public_ip = false
#   }

#   depends_on = [
#     aws_lb_listener.https
#   ]
# }

# Route 53 Zone
# resource "aws_route53_zone" "primary" {
#   name = "abdelhakimyusuf.com"
# }

# # ACM Certificate
# resource "aws_acm_certificate" "this" {
#   domain_name               = "abdelhakimyusuf.com"
#   subject_alternative_names = ["www.abdelhakimyusuf.com"]
#   validation_method         = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # Certificate DNS Validation Records
# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.this.domain_validation_options :
#     dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   zone_id = aws_route53_zone.primary.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   ttl     = 60
#   records = [each.value.record]
# }

# # ACM Certificate Validation
# resource "aws_acm_certificate_validation" "this" {
#   certificate_arn         = aws_acm_certificate.this.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
# }

# # Route 53 Alias Record for ALB
# resource "aws_route53_record" "alb" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "abdelhakimyusuf.com"
#   type    = "A"

#   alias {
#     name                   = aws_lb.this.dns_name
#     zone_id                = aws_lb.this.zone_id
#     evaluate_target_health = true
#   }
# }

# data "cloudflare_zone" "this" {
#   zone_id = var.zone_id
# }

# # ACM CNAME Records
# resource "cloudflare_dns_record" "acm_validation" {
#   for_each = { for d in aws_acm_certificate.this.domain_validation_options : d.domain_name => d }

#   zone_id = data.cloudflare_zone.this.id
#   name    = each.value.resource_record_name
#   type    = each.value.resource_record_type
#   ttl     = 120
#   proxied = false
#   content = each.value.resource_record_value
# }

# # ALB CNAME Record for www
# resource "cloudflare_dns_record" "www" {
#   zone_id = data.cloudflare_zone.this.id
#   name    = "www"
#   type    = "CNAME"
#   ttl     = 1
#   proxied = true
#   content = aws_lb.this.dns_name
# }