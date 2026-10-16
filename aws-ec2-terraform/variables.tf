variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "subnet_id" {
  type        = string
  description = "Existing subnet ID"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Existing security group IDs"
}

variable "environment" {
  type    = string
  default = "Production"
}

variable "owner" {
  type = string
}

variable "instances" {
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
    key_name      = string
    iops          = optional(number)
  }))

  validation {
    condition     = length(var.instances) == 5
    error_message = "Exactly five instances are required."
  }

  validation {
    condition = (
      contains(keys(var.instances), "critical-db") &&
      length(distinct([for n, v in var.instances : v.instance_type])) == 5 &&
      length(distinct([for n, v in var.instances : v.volume_type])) == 5 &&
      alltrue([
        for n, v in var.instances :
        contains(["gp2", "gp3", "io1", "io2", "standard"], v.volume_type)
      ])
    )
    error_message = "Provide five distinct instance types and volume types, including critical-db and supported root volume types."
  }

  validation {
    condition = alltrue([
      for n, v in var.instances :
      contains(["io1", "io2"], v.volume_type) ?
      try(v.iops >= 100, false) : v.iops == null
    ])
    error_message = "io1/io2 require IOPS; omit IOPS for other volume types."
  }
}
