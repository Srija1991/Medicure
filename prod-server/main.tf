  resource "aws_instance" "prod-server" {
  ami           = "ami-02eb7a4783e7e9317" 
  instance_type = "t2.medium" 
  key_name = "apr26"
  vpc_security_group_ids= ["sg-0c69f259b0ea97dc0"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./apr26.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "prod-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.prod-server.public_ip} > inventory "
  }
  }
