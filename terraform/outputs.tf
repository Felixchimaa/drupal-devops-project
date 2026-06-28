output "server1_public_ip" {
  value = aws_instance.drupal_server_1.public_ip
}

output "server2_public_ip" {
  value = aws_instance.drupal_server_2.public_ip
}
output "rds_endpoint" {
  value = aws_db_instance.drupal_db.endpoint
}
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.drupal_alb.dns_name
}

