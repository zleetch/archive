module "test-vpc" {
  source   = "./modules/network"
  vpc_name = "test"
  vpc_cidr = "192.168.0.0/16"
  region   = var.region
  vsw = [
    {
      name = "test"
      cidr = "192.168.1.0/24"
      zone = "a"
    },
    {
      name = "test"
      cidr = "192.168.2.0/24"
      zone = "b"
    },
    {
      name = "test"
      cidr = "192.168.0.0/24"
      zone = "c"
    }
  ]
  nat_name = "test"
  nat_vsw  = "test"
  tag = {
    Team = "devops"
  }
}

module "test-key" {
  source   = "./modules/keypair"
  key_name = "test"
  tag = {
    Team = "devops"
  }
}

module "test-sg" {
  source        = "./modules/securityGroup"
  secgroup_name = "test"
  vpc_id        = module.test-vpc.vpc_id
  sg_rule = {
    ssh = {
      rule_type  = "ingress"
      protocol   = "tcp"
      port_range = "22/22"
      ip         = "0.0.0.0/0"
    },
    http = {
      rule_type  = "ingress"
      protocol   = "tcp"
      port_range = "80/80"
      ip         = "0.0.0.0/0"
    }
  }
  tag = {
    Team = "devops"
  }
}