# For proxmox; applies to different nodes.
variable "proxmox_endpoint" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

# variable "proxmox_api_token" {
#   type      = string
#   sensitive = true
# }

variable "proxmox_node" {
  type = string
}

# variable "proxmox_ssh_username" {
#   type = string
# }

variable "vm_username" {
  type = string
}

variable "vm_password" {
  type      = string
  sensitive = true
}
