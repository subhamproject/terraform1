resource "aws_instance" "subham" {
  ami                    = var.AMI
  instance_type          = var.TYPE
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_connection.id]
  count                  = 1
  key_name               = aws_key_pair.my-key.key_name
  tags = {
    Name = "HelloWorld"
  }
  lifecycle {
    create_before_destroy = true
  }

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",
      "/tmp/install.sh",
    ]
  }

  connection {
    user        = var.USER
    private_key = file(var.PEM)
    host        = aws_instance.subham[count.index].public_ip
  }
}
resource "aws_key_pair" "my-key" {
  key_name   = "key"
  public_key = "${file("mykey.pub")}"
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-locking" {
  name           = "terraform-state-lock"
  hash_key       = "LockID"
  read_capacity  = 2
  write_capacity = 2
  depends_on     = [aws_instance.subham]
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "DynamoDB Terraform State Locking"
  }
}

#/*
#output "in_public_ip" {#
#  value = aws_instance.subham.public_ip
#}
