# variable "vpcID" {
# }

variable "jenkins_admin_password" {
  sensitive = true
}

variable "keypair_name" {
}

variable "vpc_id" {
}

variable "master_volume_size" {
  description = "Data volume size for the Master instance (GB)."
  type        = number
  default     = 8
}

variable "master_volume_type" {
  description = "Data volume type for the Master instance."
  type        = string
  default     = "gp3"
}

variable "slave_volume_size" {
  description = "Root volume size for the Slave instances (GB)."
  type = number
  default = 8
}

variable "slave_volume_type" {
  description = "Root volume type for the Slave instances."
  type = string
  default = "gp3"
}
