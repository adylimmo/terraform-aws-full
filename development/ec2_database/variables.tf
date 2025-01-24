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
  default     = "../security_group_private/terraform.tfstate"
}