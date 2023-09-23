locals {
  name = "us-team1"
}
module "vpc" {
  source                 = "./module/vpc"
  vpc_cidr               = "10.0.0.0/16"
  tag-vpc                = "${local.name}-vpc"
  public_subnet_1_cidr   = "10.0.1.0/24"
  az_1                   = "eu-west-3a"
  tag-Public_subnet_1    = "${local.name}-Public_subnet_1"
  public_subnet_2_cidr   = "10.0.2.0/24"
  az_2                   = "eu-west-3b"
  tag-Public_subnet_2    = "${local.name}-Public_subnet_2"
  private_subnet_1_cidr  = "10.0.3.0/24"
  tag-Private_subnet_1   = "${local.name}-Private_subnet_1"
  private_subnet_2_cidr  = "10.0.4.0/24"
  tag-Private_subnet_2   = "${local.name}-Private_subnet_2"
  tag-igw                = "${local.name}-igw"
  key_name               = "keypairs"
  keypair_path           = "~/Keypairs/pacpujpeu2.pub"
  tag-natgw              = "${local.name}-natgw"
  RT_cidr                = "0.0.0.0/0"
  tag-public_RT          = "${local.name}-public_RT"
  tag-private_RT         = "${local.name}-private_RT"
  port_ssh               = 22
  tag-Bastion-Ansible_SG = "${local.name}-Bastion-Ansible_SG"
  port_proxy             = 8080
  port_http              = 80
  port_https             = 443
  tag-Docker-SG          = "${local.name}-Docker-SG"
  tag-Jenkins_SG         = "${local.name}-Jenkins_SG"
  port_sonar             = 9000
  tag-Sonarqube_SG       = "${local.name}-Sonarqube_SG"
  port_proxy_nex         = 8081
  port_proxy_nex_2       = 8085
  tag-Nexus_SG           = "${local.name}-Nexus_SG"
  port_mysql             = 3306
  RT_cidr_2              = ["10.0.3.0/24", "10.0.4.0/24"]
  tag-MySQL-SG           = "${local.name}-MySQL-SG"
}
module "Bastion" {
  source             = "./module/bastion"
  Public_subnet_1    = module.vpc.Public_subnet_1
  private_key        = module.vpc.private-key
  Bastion_Ansible_SG = module.vpc.Bastion_Ansible_SG
  key_name           = module.vpc.key_name
  bastion-name       = "${local.name}-Bastion"
}
module "jenkins" {
  source               = "./module/jenkins"
  Private_subnet_2     = module.vpc.private_subnet_2
  Jenkins_SG           = module.vpc.Jenkins_SG
  nexus-ip             = module.nexus.nexus_ip
  newrelic-acct-id     = ""
  newrelic-license-key = ""
  jenkins-server-name  = "${local.name}-Jenkins"
  key_name             = module.vpc.key-name
}