resource "proxmox_download_file" "ubuntu_server_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  file_name    = "ubuntu-24.04-server-cloudimg-amd64.iso"
  node_name    = var.proxmox_node
  overwrite    = false
  url          = "https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
}

# TODO: Create modules combining both control plane vm and worker vms
resource "proxmox_virtual_environment_vm" "control_plane_vm" {
  count       = var.control_plane_count
  name        = "k8s-control-plane-${count.index}"
  description = "Kubernetes control plane node"
  node_name   = var.proxmox_node

  machine = "q35"

  cpu {
    cores = var.control_plane_cpu
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.control_plane_memory
    floating  = var.control_plane_memory
  }

  # TODO: Learn details about storage
  disk {
    discard   = "on"
    file_id   = proxmox_download_file.ubuntu_server_cloud_image.id
    interface = "scsi0"
    iothread  = true
    size      = var.control_plane_disk_size
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
        address = "192.168.1.${var.control_plane_ip_start + count.index}/24"
        gateway = var.gateway_ip
      }
    }

    user_account {
      username = var.vm_username
      password = var.vm_password
    }
  }

  agent {
    enabled = true
  }
}

resource "proxmox_virtual_environment_vm" "worker_vm" {
  count       = var.worker_count
  name        = "k8s-worker-${count.index}"
  description = "Kubernetes worker node ${count.index}"
  node_name   = var.proxmox_node

  machine = "q35"

  cpu {
    cores = var.worker_cpu
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.worker_memory
    floating  = var.worker_memory
  }

  disk {
    discard   = "on"
    file_id   = proxmox_download_file.ubuntu_server_cloud_image.id
    interface = "scsi0"
    iothread  = true
    size      = var.worker_disk_size
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

  initialization {
    datastore_id = "local-lvm"

    ip_config {
      ipv4 {
        address = "192.168.1.${var.worker_ip_start + count.index}/24"
        gateway = var.gateway_ip
      }
    }

    user_account {
      username = var.vm_username
      password = var.vm_password
    }
  }

  agent {
    enabled = true
  }
}
