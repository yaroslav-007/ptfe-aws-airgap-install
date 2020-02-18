resource "aws_instance" "ptfe" {

  ami                    = "ami-0be057a22c63962cb"
  instance_type          = "t2.large"
  subnet_id              = aws_subnet.ptfe-vpc-private-subnet.id        
  vpc_security_group_ids = [aws_security_group.vpc_ssh_icmp_echo_sg.id] 
  key_name               = aws_key_pair.yaro-ssh.id                     
  tags = {
    Name = "Yaro-ptfe"
  }
  availability_zone = "eu-west-2a"
  root_block_device {
    volume_size = 42
  }
  provisioner "file" {
    source      = "ptfe-ec2"
    destination = "/home/ubuntu/"

    connection {
      type        = "ssh"
      host        = aws_instance.ptfe.private_ip
      user        = "ubuntu"
      private_key = file("./ptfe-ec2/privkey.pem")

      bastion_host        = aws_instance.hopping-station.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file("./ptfe-ec2/privkey.pem")
    }

  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/ubuntu/ptfe-ec2/ptfe-script.sh",
    ]
    connection {
      type        = "ssh"
      host        = aws_instance.ptfe.private_ip
      user        = "ubuntu"
      private_key = file("./ptfe-ec2/privkey.pem")

      bastion_host        = aws_instance.hopping-station.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file("./ptfe-ec2/privkey.pem")
    }
  }
  private_ip = "10.0.1.161"

  timeouts {
    delete = "1m"
  }


  depends_on = [aws_internet_gateway.ptfe-vpc-internet-gw]
}


resource "aws_key_pair" "yaro-ssh" {
  key_name   = "yaro-ssh"
  public_key = "<PUBLIC_KEY of ./ptfe-ec2/cert.pem>"
}

output "instance_ip_addr" {
  value = aws_instance.ptfe.private_ip
}