resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "web_server1" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  provisioner "file" {
    source      = "userdata.sh"
    destination = "/tmp/userdata.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      "sudo /tmp/userdata.sh"
    ]
  }

  connection {
    host        = self.public_ip
    user        = var.INSTANCE_USERNAME
    agent       = true
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
  tags = {
    "Name" = "Web-Server1"
  }
}

resource "aws_instance" "web_server2" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  provisioner "file" {
    source      = "userdata.sh"
    destination = "/tmp/userdata.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      "sudo /tmp/userdata.sh"
    ]
  }

  connection {
    host        = self.public_ip
    user        = var.INSTANCE_USERNAME
    agent       = true
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  tags = {
    Name = "Web-Server2"
  }
}

