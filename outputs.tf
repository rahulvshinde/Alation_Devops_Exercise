
output "web1_public_ip" {
  value = aws_instance.web_server1.public_ip
}

output "web1_private_ip" {
  value = aws_instance.web_server1.private_ip
}

output "web2_public_ip" {
  value = aws_instance.web_server2.public_ip
}

output "web2_private_ip" {
  value = aws_instance.web_server2.private_ip
}

output "haproxy_public_ip" {
  value = aws_instance.haproxy-lb.public_ip
}

output "haproxy_private_ip" {
  value = aws_instance.haproxy-lb.private_ip
}
