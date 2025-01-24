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
variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "keypair_private_prod.pem"
}

variable "state_path" {
  description = "Path ke terraform.tfstate"
  type        = string
  default     = "../vpc/terraform.tfstate"
}