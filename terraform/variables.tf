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
#   type = string
# }

variable "proxmox_node" {
  type = string
}

variable "gateway_ip" {
  type    = string
  default = "192.168.1.1"
}

# For VMs; applies to different VMs running inside proxmox.
variable "vm_username" {
  type = string
}

variable "vm_password" {
  type      = string
  sensitive = true
}

# Kubernetes related stuff.
variable "control_plane_id_start" {
  description = "this is for proxmox id assignment. Also used for static ip."
  type        = number
  default     = 301
}

variable "control_plane_count" {
  type    = number
  default = 1
}

variable "control_plane_cpu" {
  description = "Core count"
  type        = number
  default     = 1
}

variable "control_plane_memory" {
  description = "RAM in MB"
  type        = number
  default     = 2048
}

variable "control_plane_disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 100
}

variable "worker_id_start" {
  description = "this is for proxmox id assignment. Also used for static ip."
  type        = number
  default     = 401
}

variable "worker_count" {
  type    = number
  default = 2
}

variable "worker_cpu" {
  description = "Core count"
  type        = number
  default     = 1
}

variable "worker_memory" {
  description = "RAM in MB"
  type        = number
  default     = 2048
}

variable "worker_disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 100
}
