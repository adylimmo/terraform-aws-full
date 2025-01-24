output "security_group_id" {
  value = aws_security_group.anakdevops_sg.id
}

output "key_pair_id" {
  value = aws_key_pair.key_pair.id
}

output "key_public_key" {
  value = aws_key_pair.key_pair.public_key
}
output "subnet_id" {
  value = aws_network_interface.sub_priv.subnet_id
  description = "The ID of the subnet associated with the network interface"
}
output "vpc_id" {
  value = aws_security_group.anakdevops_sg.vpc_id
  description = "The ID of the VPC where the security group is created"
}