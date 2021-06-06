data "template_file" "haproxyconf" {
  template = file("haproxy.cfg.tpl")

  vars = {
    web1_priv_ip = aws_instance.web_server1.private_ip
    web2_priv_ip = aws_instance.web_server2.private_ip
  }
}
