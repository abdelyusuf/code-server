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
