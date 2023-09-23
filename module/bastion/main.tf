resource  "aws_instance"  "us-team-bastion" {
  ami                         = "ami-0fcf52bcf5db7b003"
  instance_type               = "t2.micro"
  subnet_id                   = var.Public_subnet_1
  associate_public_ip_address = true
  vpc_security_group_ids      = var.Bastion_Ansible_SG
  key_name                    = var.key_name
  user_data                   = local.bastion_user_data
  tags = {
    Name =var.bastion-name 
  }
}