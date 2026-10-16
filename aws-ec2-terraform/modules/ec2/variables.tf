variable "instances" {
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
    key_name      = string
    iops          = optional(number)
  }))
}
variable "ami_id" { type = string }
variable "subnet_id" { type = string }
variable "security_group_ids" { type = list(string) }
variable "environment" { type = string }
variable "owner" { type = string }
