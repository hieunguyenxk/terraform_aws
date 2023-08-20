variable "vpc_cidr_block" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "subnet_configs" {
  type = map(any)
}

variable "cidr_block_rtb_public" {
  type = string
}

variable "cidr_block_rtb_private" {
  type = string
}

variable "sg_configs" {
  type = map(any)
}

variable "tags" {

}