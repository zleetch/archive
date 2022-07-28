terraform {
  required_providers {
    alicloud = {
      version = "~> 1.173.0"
      source  = "hashicorp/alicloud"
    }
  }

  required_version = "~> 0.15.0"
}
