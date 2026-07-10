provider "proxmox" {
  endpoint = var.proxmox_endpoint

  username = var.proxmox_username
  password = var.proxmox_password

  insecure = true
}

# provider "proxmox" {
#     endpoint = var.node_endpoint

#     api_token = var.proxmox_api_token

#     insecure = true
# }
