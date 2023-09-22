resource  "aws_instance"  "us-team-jenkins" {
  ami                         = "ami-0fcf52bcf5db7b003"
  instance_type               = "t2.medium"
  subnet_id                   = var.Private_subnet_2
  vpc_security_group_ids      = var.Jenkins_SG
  key_name                    = var.key_name
  user_data                   = local.jenkins_user_data
  tags = {
    Name =var.jenkins-server-name 
  }
}