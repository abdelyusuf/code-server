output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the ALB"
  value       = aws_lb.this.zone_id
}
output "aws_lb_listener" {
  description = "lb listner"
  value       = aws_lb_listener.https
}

output "https_listener_arn" {
  value       = aws_lb_listener.https.arn
  description = "The ARN of the HTTPS listener for the ALB"
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "lb_dns_name" {
  value = aws_lb.this.dns_name
}

output "lb_zone_id" {
  value = aws_lb.this.zone_id
}

