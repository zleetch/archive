variable "secgroup_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "sg_rule" {
  type = map(object({
    rule_type  = string
    protocol   = string
    port_range = string
    ip         = string
  }))
}

variable "tag" {
  type = object({
    Team = string
  })
}