provider "proxmox" {
  endpoint = var.proxmox_endpoint

  username = var.proxmox_username
  password = var.proxmox_password
  # api_token = var.proxmox_api_token

  # ssh {
  #   agent    = true
  #   username = var.proxmox_ssh_username
  # }

  insecure = true
}
