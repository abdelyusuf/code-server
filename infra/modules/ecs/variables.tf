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


variable "target_group_arn" {
  type        = string
  description = "target group address"
}

variable "private_subnets" {
  type        = list(string)
  description = "list of private subnets"
}
variable "security_group" {
  description = "security group for ecs"
  type        = string
}

variable "alb_listener_arn" {
  type        = string
  description = "ARN of the HTTPS listener from the ALB module"
}
