output "vpc_id" {
  value = alicloud_vpc.vpc.id
}

output "vpc_cidr" {
  value = alicloud_vpc.vpc.cidr_block
}

output "vsw_id" {
  value = [for x in alicloud_vswitch.vsw : x.id]
}

output "natgw_id" {
  value = local.create_nat != null ? alicloud_nat_gateway.natgw[0].id : null
}

output "natgw_ip" {
  value = local.create_nat != null ? alicloud_eip_address.natgw[0].ip_address : null
}

output "natgw_snat" {
  value = local.create_nat != null ? alicloud_nat_gateway.natgw[0].snat_table_ids : null
}