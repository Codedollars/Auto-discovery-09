output "jenkins-ip" {
  value = aws_instance.us-team-jenkins.private_ip
}

output "jenkins server" {
  value = aws_instance.us-team-jenkins.id
}
