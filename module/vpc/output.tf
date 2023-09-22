# # output "ansible" {
#   value = module.ansible.ansible-ip
# }
# output "sonarqube" {
#   value = module.sonarqube.sonarqube_ip
# }
# output "bastion" {
#   value = module.bastion.bastion
# }
# output "nexus" {
#   value = module.nexus_server.nexus_public-ip
# }
# output "jenkins" {
#   value = module.jenkins.jenkins_server_ip
# }
# output "docker" {
#   value = module.docker.docker_server_ip
# }
output "key-name" {
  value = aws_key_pair.keypair.key_name
}
output "key-id" {
  value = aws_key_pair.keypair.id
}
output "private-key" {
  value = tls_private_key.keypair-1.private_key_pem
}
