module "demo-vpc" {
  source   = "./modules/network"
  vpc_name = "satu"
  vpc_cidr = "192.168.0.0/16"
  region   = var.region
  vsw = [
    {
      name = "satu"
      cidr = "192.168.1.0/24"
      zone = "a"
    },
    {
      name = "satu"
      cidr = "192.168.2.0/24"
      zone = "b"
    },
    {
      name = "satu"
      cidr = "192.168.0.0/24"
      zone = "c"
    }
  ]
  nat_name = "demo"
  nat_vsw  = "satu"
  tag = {
    Team  = "devops"
    Runby = "terraform"
  }
}