output "security_groups" {
  description = "security groups for sg"
  value       = aws_default_security_group.this.id
}

