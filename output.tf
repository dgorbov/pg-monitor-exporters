resource "local_file" "pg_exporter_pk" {
  content         = tls_private_key.pg_exporter.private_key_pem
  filename        = "ansible/pg_exporter_pk.pem"
  file_permission = 600
}

resource "local_file" "ansible_hosts" {
  content = templatefile("templates/ansible_hosts", {
    EXPORTER_IP = aws_instance.exporter_instance.public_ip
  })
  filename = "ansible/hosts"
}

output "exporter_ip" {
  value = aws_instance.exporter_instance.public_ip
}