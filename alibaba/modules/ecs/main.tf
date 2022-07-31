locals {
  env        = terraform.workspace
  ecs_name   = "${var.ecs_name}-${local.env}"
  ecs_id     = alicloud_instance.ecs.*.id
  eip_name   = "eip-${local.ecs_name}"
  image      = "${var.image_name}_${var.image_version}"
  image_id   = data.alicloud_images.image.images.0.id
  ecs_type   = data.alicloud_instance_types.ecs_type.instance_types.0.id
  vsw        = "vsw-${var.vsw_name}-${local.env}"
  vsw_id     = data.alicloud_vswitches.ecs_vsw.*.vswitches.0.id
  create_eip = var.attach_eip ? var.replica : 0
  tags       = merge({ Env = local.env, Runby = "terraform" }, var.tag)
}

data "alicloud_images" "image" {
  name_regex = "^${local.image}"
}

data "alicloud_instance_types" "ecs_type" {
  instance_type_family = "ecs.${var.ecs_type}"
  cpu_core_count       = var.ecs_cpu
  memory_size          = var.ecs_mem
}

data "alicloud_vswitches" "ecs_vsw" {
  count      = length(var.zone)
  name_regex = "^${local.vsw}-${var.zone[count.index]}"
}

resource "alicloud_eip_address" "ecs_eip" {
  count                = local.create_eip
  address_name         = "${local.eip_name}-${count.index}"
  isp                  = "BGP"
  bandwidth            = 200
  internet_charge_type = "PayByTraffic"
  payment_type         = "PayAsYouGo"
  tags                 = merge({ Name = local.eip_name }, local.tags)
}

resource "alicloud_instance" "ecs" {
  count                = var.replica
  instance_name        = "${local.ecs_name}-${count.index}"
  host_name            = "${local.ecs_name}-${count.index}"
  vswitch_id           = local.vsw_id[count.index % length(var.zone)]
  security_groups      = var.sg_id
  key_name             = var.keypair
  image_id             = local.image_id
  instance_type        = local.ecs_type
  availability_zone    = "${var.region}${var.zone[count.index % length(var.zone)]}"
  system_disk_category = var.system_type
  system_disk_size     = var.system_size
  system_disk_name     = "system-${local.ecs_name}"
  tags                 = merge({ Name = "${local.ecs_name}-${count.index}" }, local.tags)
  depends_on = [
    data.alicloud_images.image,
    data.alicloud_instance_types.ecs_type,
    data.alicloud_vswitches.ecs_vsw
  ]
}

resource "alicloud_eip_association" "ecs_eip" {
  count         = local.create_eip
  allocation_id = alicloud_eip_address.ecs_eip[count.index].id
  instance_id   = alicloud_instance.ecs[count.index].id
  instance_type = "EcsInstance"
  depends_on = [
    alicloud_instance.ecs,
    alicloud_eip_address.ecs_eip
  ]
}