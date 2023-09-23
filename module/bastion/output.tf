
output "bastion-ip" {
  value = aws_instance.us-team-bastion.public_ip
}
output "bastion-id" {
  value = aws_instance.us-team-bastion.id
}