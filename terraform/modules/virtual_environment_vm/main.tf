resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.vm_config.name
  description = var.vm_config.description
  node_name   = var.proxmox_node

  machine = "q35"

  cpu {
    cores = var.vm_config.cpu_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.vm_config.memory
    floating  = var.vm_config.memory
  }

  disk {
    discard   = "on"
    file_id   = var.vm_config.file_id
    interface = "scsi0"
    iothread  = true
    size      = var.vm_config.disk_size
    ssd       = true
  }

  efi_disk {
    datastore_id      = "local-lvm"
    pre_enrolled_keys = true
  }

  network_device {
    bridge   = "vmbr0"
    firewall = true
  }

  bios = "ovmf"

  operating_system {
    type = "l26"
  }

  # TODO: vm ip should not be coupled with the vm id
  initialization {
    datastore_id = "local-lvm"

    ip_config {
      ipv4 {
        address = var.vm_config.ip_address
        gateway = var.vm_config.gateway_ip
      }
    }

    user_account {
      username = var.vm_credentials.username
      password = var.vm_credentials.password
    }
  }

# Keep enabled = false when creating. Turn it on after the first boot
  agent {
    enabled = false
  }
}
