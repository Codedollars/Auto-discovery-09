provider "aws" {
    profile = "Groupaccess"
    region = "us-west-2"
}

# RSA key of size 4096 bits
resource "tls_private_key" "keypair-4" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#creating private key
resource "local_file" "keypair-4" {
 content = tls_private_key.keypair-4.private_key_pem
 filename = "vault-keypair"
 file_permission =  "600"
}

# creating ec2 keypair
resource "aws_key_pair" "vault-keypair" {
    key_name = "vault-keypair"
    public_key = tls_private_key.keypair-4.public_key_openssh
}

#security group for vault
resource "aws_security_group" "vault-sg" {
    name = "vault-sg"
    description = "Allow Inbound Traffic"

    ingress  {
      description = "https port"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks =["0.0.0.0/0"]
    }
    ingress {
      description = "vault port"
      from_port   = 8200
      to_port     = 8200
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      description = "ssh access"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      description = "http access"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      name ="vault-sg"
    }
}

#creating Ec2 for Terraform Vault
resource "aws_instance" "vault" {
    ami                         = "ami-0fcf52bcf5db7b003"
    instance_type               = "t2.medium"
    vpc_security_group_ids      = [aws_security_group.vault-sg.id]
    key_name                    = aws_key_pair.vault-keypair.id
    iam_instance_profile        = aws_iam_instance_profile.vault-kms-unseal.id
    associate_public_ip_address = true
    user_data                   = local.vault_user_data
    tags = {
      Name = "vault-server"
    }
}

resource "aws_kms_key" "vault" {
    description               = "vault unseal key"
    deletion_window_in_days   = 10

    tags = {
      Name = "vault-kms-unseal"
    }
}

data "aws_route53_zone" "route53_zone" {
    name         = "volakinwand.com"
    private_zone = false
}

resource "aws_route53_record" "vault_record" {
    zone_id  = data.aws_route53_zone.route53_zone.id
    name     = "volakinwand.com"
    type     = "A"
    records  = [aws_instance.vault.public_ip]
    ttl      = 300
}
