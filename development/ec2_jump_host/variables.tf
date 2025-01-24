variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "region" {
  description = "AWS region"
}
variable "state_path" {
  description = "Path ke terraform.tfstate"
  type        = string
  default     = "../security_group_public/terraform.tfstate"
}
variable "path_keypair_public" {
  description = "Path ke terraform.tfstate"
  type        = string
  default     = "../security_group_public/keypair_public_dev.pem"
}

variable "path_keypair_private" {
  description = "Path ke terraform.tfstate"
  type        = string
  default     = "../security_group_private/keypair_private_dev.pem"
}

variable "name_keypair_private" {
  description = "Path ke terraform.tfstate"
  type        = string
  default     = "keypair_private_dev.pem"
}
variable "name_keypair_public" {
  description = "Path ke terraform.tfstate"
  type        = string
  default     = "keypair_public_dev.pem"
}