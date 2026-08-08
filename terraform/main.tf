module "ubuntu_server_cloud_image" {
  source = "./modules/download_file"

  proxmox_node = var.proxmox_node
}

module "control_panel" {
  for_each = {
    control-panel-1 = "192.168.1.10/24"
  }

  source = "./modules/virtual_environment_vm"

  proxmox_node = var.proxmox_node

  vm_config = {
    name        = each.key
    description = "Kubernetes control plane"
    cpu_cores   = 2
    memory      = 2048
    file_id     = module.ubuntu_server_cloud_image.id
    disk_size   = 50
    ip_address  = each.value
    gateway_ip  = "192.168.1.1"
  }

  # TODO: Use Vaults
  vm_credentials = {
    username = var.vm_username
    password = var.vm_password
  }
}

module "worker_node" {
  for_each = {
    worker-node-1 = "192.168.1.11/24"
    worker-node-2 = "192.168.1.12/24"
  }

  source = "./modules/virtual_environment_vm"

  proxmox_node = var.proxmox_node

  vm_config = {
    name        = each.key
    description = "Kubernetes worker node"
    cpu_cores   = 2
    memory      = 2048
    file_id     = module.ubuntu_server_cloud_image.id
    disk_size   = 50
    ip_address  = each.value
    gateway_ip  = "192.168.1.1"
  }

  # TODO: Use Vaults
  vm_credentials = {
    username = var.vm_username
    password = var.vm_password
  }
}
