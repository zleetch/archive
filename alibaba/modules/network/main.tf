locals {
  env        = terraform.workspace
  vpc_name   = "vpc-${var.vpc_name}-${local.env}"
  vsw_cidr   = [for x in var.vsw : x.cidr]
  vsw_zone   = [for x in var.vsw : "${var.region}${x.zone}"]
  vsw_name   = [for x in var.vsw : "vsw-${x.name}-${local.env}"]
  create_nat = var.nat_name != null ? true : false
  nat_name   = var.nat_name != null ? "nat-${var.nat_name}-${local.env}-gw" : null
  eip_name   = var.nat_name != null ? "eip-${var.nat_name}-${local.env}-natgw" : null
  tags       = merge({ Env = local.env }, var.tag)
}

data "alicloud_vswitches" "natgw" {
  name_regex = "^vsw-${var.nat_vsw}-${local.env}-${var.nat_zone}"
  zone_id    = "${var.region}${var.nat_zone}"
  depends_on = [
    alicloud_vswitch.vsw
  ]
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = local.vpc_name
  cidr_block = var.vpc_cidr
  tags       = merge({ Name = local.vpc_name }, local.tags)
  #     lifecycle {
  #         prevent_destroy = prevent.value
  #     }
}

resource "alicloud_vswitch" "vsw" {
  count        = length(local.vsw_name)
  vpc_id       = alicloud_vpc.vpc.id
  vswitch_name = "${local.vsw_name[count.index]}-${replace(local.vsw_zone[count.index], var.region, "")}"
  cidr_block   = local.vsw_cidr[count.index]
  zone_id      = local.vsw_zone[count.index]
  description  = "${local.vsw_name[count.index]} with ${local.vsw_cidr[count.index]} cidr"
  tags         = merge({ Name = "${local.vsw_name[count.index]}-${replace(local.vsw_zone[count.index], var.region, "")}" }, local.tags)
  depends_on = [
    alicloud_vpc.vpc
  ]
}

resource "alicloud_eip_address" "natgw" {
  count                = local.create_nat ? 1 : 0
  address_name         = local.eip_name
  isp                  = "BGP"
  bandwidth            = 200
  internet_charge_type = "PayByTraffic"
  payment_type         = "PayAsYouGo"
  tags                 = merge({ Name = local.eip_name }, local.tags)
}

resource "alicloud_nat_gateway" "natgw" {
  count            = local.create_nat ? 1 : 0
  vpc_id           = alicloud_vpc.vpc.id
  vswitch_id       = data.alicloud_vswitches.natgw.ids[0]
  nat_gateway_name = local.nat_name
  nat_type         = var.nat_type
  payment_type     = var.nat_payment
  tags             = merge({ Name = local.nat_name }, local.tags)
  depends_on = [
    alicloud_vswitch.vsw
  ]
}

resource "alicloud_eip_association" "natgw" {
  count         = local.create_nat ? 1 : 0
  allocation_id = alicloud_eip_address.natgw[0].id
  instance_id   = alicloud_nat_gateway.natgw[0].id
  instance_type = "Nat"
  depends_on = [
    alicloud_eip_address.natgw,
    alicloud_nat_gateway.natgw
  ]
}

resource "alicloud_snat_entry" "snat_entry" {
  count           = local.create_nat ? 1 : 0
  snat_entry_name = "snat-${local.nat_name}-entry"
  snat_ip         = alicloud_eip_address.natgw[0].ip_address
  snat_table_id   = alicloud_nat_gateway.natgw[0].snat_table_ids
  source_cidr     = alicloud_vpc.vpc.cidr_block
  depends_on = [
    alicloud_eip_address.natgw,
    alicloud_nat_gateway.natgw
  ]
}