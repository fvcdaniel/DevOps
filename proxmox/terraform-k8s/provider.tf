terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.25.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://192.168.15.135:8006/"
  username = "root@pam"
  password = "romualdo2424"
  insecure = true
  ssh {
    agent = false
  }
}
