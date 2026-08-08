resource "proxmox_download_file" "ubuntu_server_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  file_name    = "ubuntu-24.04-server-cloudimg-amd64.iso"
  node_name    = var.proxmox_node
  overwrite    = false
  url          = "https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
}