resource "aws_instance" "haproxy-lb" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  connection {
    host        = self.public_ip
    user        = var.INSTANCE_USERNAME
    agent       = true
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 25",
      "sudo yum update -y",
      "sudo yum -y install haproxy"
    ]
  }
  provisioner "file" {
    content     = data.template_file.haproxyconf.rendered
    destination = "/tmp/haproxy.cfg"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg",
      "sudo service haproxy restart"
    ]
  }
  tags = {
    Name = "HAProxy-Load-Balancer"
  }
}
