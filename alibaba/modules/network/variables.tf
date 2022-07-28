variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "vsw" {
  type = list(object({
    name = string
    cidr = string
    zone = string
  }))
}

variable "nat_name" {
  type    = string
  default = null
}

variable "nat_vsw" {
  type    = string
  default = null
}

variable "nat_zone" {
  type    = string
  default = "a"
}

variable "nat_payment" {
  type    = string
  default = "PayAsYouGo"
}

variable "nat_type" {
  type    = string
  default = "Enhanced"
}

variable "tag" {
  type = object({
    Team  = string
    Runby = string
  })
}