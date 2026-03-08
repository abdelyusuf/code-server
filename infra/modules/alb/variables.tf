variable "alb_name" {
  type        = string
  description = "application load balancer name "
}


variable "container_port" {
  type        = string
  description = "cotainer port "
}


variable "health_check_path" {
  type        = string
  description = "health check path"
}
#/login

variable "ssl_policy" {
  type        = string
  description = "health check polict"
}
#"ELBSecurityPolicy-2016-08"

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "public_subnets" {
  type        = list(string)
  description = "list of public subnets"
}

variable "alb_security_group" {
  type        = string
  description = "security groups"
}

variable "certificate_arn" {
  type        = string
  description = "certificate arn"
}