output "app_eip_public_ip" {
  value = module.app.this_eip_public_ip
}

output "app_ssh_private_key_pem" {
  value = module.app.this_ssh_private_key_pem
}

output "app_ssh_public_key_pem" {
  value = module.app.this_ssh_public_key_pem
}
