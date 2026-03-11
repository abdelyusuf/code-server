variable "alb_name" {
  type        = string
  description = "application load balancer name "
}

variable "health_check_path" {
  type        = string
  description = "health check path"
}

variable "ssl_policy" {
  type        = string
  description = "health check polict"
}


variable "app_name" {
  type        = string
  description = "app name"
}

variable "container_image" {
  type        = string
  description = "container image from ecr"
}

variable "desired_count" {
  type        = string
  description = "desired amount of containers"
}


variable "container_port" {
  type        = string
  description = "container port exposed"
}


variable "task_cpu" {
  type        = string
  description = "cpu for ecs"
}


variable "task_memory" {
  type        = string
  description = "how much memory"
}

variable "allowed_ingress_cidrs" {
  type        = list(string)
  description = "cidr list of ips allowed ingress"
}
variable "allowed_egress_cidrs" {
  type        = list(string)
  description = "list of egress cidrs allowed"
}

variable "app_port" {
  type        = string
  description = "app port for listening and exposed"
}

variable "http_port" {
  type        = string
  description = "http port exposed 80"
}

variable "https_port" {
  type        = string
  description = "https port exposed 443"
}


variable "public_subnet_a_cidr" {
  type        = string
  description = "public subnet a cidr"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "public subnet b cidr"
}


variable "private_subnet_a_cidr" {
  type        = string
  description = "private subnet a cidr"
}


variable "private_subnet_b_cidr" {
  type        = string
  description = "private subnet b cidr"
}


variable "az_a" {
  type        = string
  description = "availability zone"
}


variable "az_b" {
  type        = string
  description = "availability zone"
}


variable "project_name" {
  type        = string
  description = "name of the project"
}

variable "domain_name" {
  type        = string
  description = "the domain name for infra"
}

