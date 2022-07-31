variable "ecs_name" {
  type = string
}

variable "ecs_type" {
  type    = string
  default = "c6"
}

variable "ecs_cpu" {
  type    = number
  default = 4
}

variable "ecs_mem" {
  type    = number
  default = 8
}

variable "image_name" {
  type    = string
  default = "ubuntu"
}

variable "image_version" {
  type    = string
  default = "22"
}

variable "vsw_name" {
  type = string
}

variable "replica" {
  type    = number
  default = 1
}

variable "zone" {
  type = list(string)
}

variable "attach_eip" {
  type    = bool
  default = false
}

variable "sg_id" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "keypair" {
  type = string
}

variable "system_size" {
  type    = number
  default = 20
}

variable "system_type" {
  type    = string
  default = "cloud_efficiency"
}

variable "tag" {
  type = object({
    Team = string
  })
}