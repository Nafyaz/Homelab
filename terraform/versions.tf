terraform {
  required_version = "~> 1.15.8"

  cloud {
    organization = "nafyaz"

    workspaces {
      name = "laddu"
    }
  }

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.111.1"
    }
  }
}
