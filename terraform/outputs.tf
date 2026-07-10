output "control_plane_ips" {
  description = "IPs of the control plane nodes"
  value = [
    for vm in proxmox_virtual_environment_vm.control_plane_vm :
    try(vm.ipv4_addresses[1][0], "awaiting-guest-agent")
  ]
}

output "worker_ips" {
  description = "IPs of the worker nodes"
  value = [
    for vm in proxmox_virtual_environment_vm.worker_vm :
    try(vm.ipv4_addresses[1][0], "awaiting-guest-agent")
  ]
}
