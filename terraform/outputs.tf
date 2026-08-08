output "control_plane_ips" {
  description = "IPs of the control plane nodes"
  value = [
    for vm in module.control_panel :
    try(vm.ipv4_addresses[1][0], "awaiting-guest-agent")
  ]
}

output "worker_ips" {
  description = "IPs of the worker nodes"
  value = [
    for vm in module.worker_node :
    try(vm.ipv4_addresses[1][0], "awaiting-guest-agent")
  ]
}
