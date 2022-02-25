variable "app_eip_list" {
  description = "IP address of AWS instance"
  type = list(string)
}

variable "app_ssh_private_key_pem" {
  description = "The private key data in PEM format."
  type = string
}

variable "app_ssh_public_key_pem" {
  description = "The public key data in PEM format."
  type = string
}
