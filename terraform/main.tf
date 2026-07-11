resource "proxmox_download_file" "ubuntu_server_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.proxmox_node
  url          = "https://releases.ubuntu.com/24.04.4/ubuntu-24.04.4-live-server-amd64.iso"
  overwrite    = false
}

# TODO: Create modules combining both control plane vm and worker vms
resource "proxmox_virtual_environment_vm" "control_plane_vm" {
  count       = var.control_plane_count
  name        = "server"
  description = "Kubernetes control plane node"
  node_name   = var.proxmox_node
  vm_id       = var.control_plane_id_start + count.index

  agent {
    enabled = false
  }

  cpu {
    cores = var.control_plane_cpu
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.control_plane_memory
    floating  = var.control_plane_memory
  }

  # TODO: Learn details about storage
  cdrom {
    file_id = proxmox_download_file.ubuntu_server_image.id
  }

  disk {
    discard   = "on"
    interface = "scsi0"
    iothread  = true
    size      = var.worker_disk_size
    ssd       = true
  }

  network_device {
    bridge = "vmbr0"
  }

  bios = "ovmf"

  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.${var.control_plane_id_start + count.index}/24"
        gateway = var.gateway_ip
      }
    }

    user_account {
      username = var.vm_username
      password = var.vm_password
    }
  }
}

resource "proxmox_virtual_environment_vm" "worker_vm" {
  count       = var.worker_count
  name        = "node-${count.index}"
  description = "Kubernetes worker node ${count.index}"
  node_name   = var.proxmox_node
  vm_id       = var.worker_id_start + count.index

  agent {
    enabled = false
  }

  cpu {
    cores = var.worker_cpu
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.worker_memory
    floating  = var.worker_memory
  }

  cdrom {
    file_id = proxmox_download_file.ubuntu_server_image.id
  }

  disk {
    discard   = "on"
    interface = "scsi0"
    iothread  = true
    size      = var.worker_disk_size
    ssd       = true
  }

  network_device {
    bridge = "vmbr0"
  }

  bios = "ovmf"

  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.${var.worker_id_start + count.index}/24"
        gateway = var.gateway_ip
      }
    }

    user_account {
      username = var.vm_username
      password = var.vm_password
    }
  }
}
