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

variable "vpc_id" {
  type        = string
  description = "vpc id needs to be outputted"
}