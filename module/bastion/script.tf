locals {
   bastion_user_data = <<-EOF
   #!/bin/bash
echo " ${var.private_key}" >> /home/ec2-user/key.pem
chown 400  /home/ec2-user/key.pem
sudo hostnamectl set-hostname Bastion
EOF
}
