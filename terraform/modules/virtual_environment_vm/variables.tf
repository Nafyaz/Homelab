variable "proxmox_node" {
  type = string
}

variable "vm_config" {
  type = object({
    name        = string
    description = string
    cpu_cores   = number
    memory      = number
    file_id     = string
    disk_size   = number
    ip_address  = string
    gateway_ip  = optional(string, "192.168.1.1")
  })
}

variable "vm_credentials" {
  type = object({
    username = string
    password = string
  })

  sensitive = true
  #   ephemeral = true
}
