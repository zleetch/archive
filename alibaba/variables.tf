variable "access_key" {
  sensitive = true
}

variable "secret_key" {
  sensitive = true
}

variable "region" {
  type    = string
  default = "ap-southeast-5"
}