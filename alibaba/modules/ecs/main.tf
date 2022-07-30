locals {
  env      = terraform.workspace
  ecs_name = "${var.ecs_name}-${local.env}"

  tags = merge({ Env = local.env, Runby = "terraform" }, var.tag)
}