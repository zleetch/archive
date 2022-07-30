locals {
  env           = terraform.workspace
  secgroup_name = "sg-${var.secgroup_name}-${local.env}"
  tags          = merge({ Env = local.env, Runby = "terraform" }, var.tag)
}

resource "alicloud_security_group" "secgroup" {
  name   = local.secgroup_name
  vpc_id = var.vpc_id
  tags   = merge({ Name = local.secgroup_name }, local.tags)
}

resource "alicloud_security_group_rule" "secgroup_rule" {
  for_each          = var.sg_rule
  type              = each.value.rule_type
  ip_protocol       = each.value.protocol
  port_range        = each.value.port_range
  cidr_ip           = each.value.ip
  nic_type          = "intranet"
  policy            = "accept"
  security_group_id = alicloud_security_group.secgroup.id
  depends_on = [
    alicloud_security_group.secgroup
  ]
}