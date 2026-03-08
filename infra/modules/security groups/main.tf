
# secuirty groups 
resource "aws_default_security_group" "this" {
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = var.http_port
    to_port     = var.http_port
    cidr_blocks = var.allowed_ingress_cidrs
  }

  ingress {
    protocol    = "tcp"
    from_port   = var.https_port
    to_port     = var.https_port
    cidr_blocks = var.allowed_ingress_cidrs
  }

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = var.allowed_ingress_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_egress_cidrs
  }
}
