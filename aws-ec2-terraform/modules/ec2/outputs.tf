output "instance_ids" {
  value = merge(
    { for n, v in aws_instance.protected : n => v.id },
    { for n, v in aws_instance.regular : n => v.id }
  )
}

output "private_ips" {
  value = merge(
    { for n, v in aws_instance.protected : n => v.private_ip },
    { for n, v in aws_instance.regular : n => v.private_ip }
  )
}
