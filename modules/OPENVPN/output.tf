output "openvpn" {
  description = "The name of the Auto Scaling Group"
  value       = aws_instance.web.id
}
