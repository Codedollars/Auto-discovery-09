locals {
    jenkins_user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum upgrade -y
sudo yum install wget -y
sudo yum install git maven -y
sudo yum install java-11-openjdk -y
sudo wget https://get.jenkins.io/redhat/jenkins-2.411-1.1.noarch.rpm
sudo rpm -ivh jenkins-2.411-1.1.noarch.rpm
sudo yum update -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
sudo systemctl enable  docker
sudo systemctl enable  docker 
sudo usermod -aG docker jenkins 
sudo usermod -aG docker ec2-user
sudo chmod 777 /var/run/docker.sock
sudo cat <<EOT>> /etc/docker/daemon.json
{
    "insecure-registeries" : ["${var.nexus-ip}:8085"]
}
EOT

sudo systemctl restart docker 
"install newrelic agent 
curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && sudo NEW_RELIC_API_KEY="${newrelic-license-key}" NEW_RELIC_ACCOUNT_ID="${newrelic-acct-id}" /usr/local/bin/newrelic install -y

sudo hostnamectl set-hostname Jenkins
EOF
}