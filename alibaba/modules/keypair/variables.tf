variable "key_name" {
  type = string
}

variable "tag" {
  type = object({
    Team = string
  })
}