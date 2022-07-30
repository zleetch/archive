locals {
  env      = terraform.workspace
  key_name = "key-${var.key_name}-${local.env}"
  tags     = merge({ Env = local.env, Runby = "terraform" }, var.tag)
}

resource "alicloud_ecs_key_pair" "key_pair" {
  key_pair_name = local.key_name
  tags          = merge({ Name = local.key_name }, local.tags)
}

