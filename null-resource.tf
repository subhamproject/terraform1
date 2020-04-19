resource "null_resource" "getting_public_ip_to_file" {
  provisioner "local-exec" {
    command = "echo ${aws_security_group.allow_ssh_connection.id} > hosts"
  }
}
