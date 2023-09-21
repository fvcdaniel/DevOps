resource "proxmox_virtual_environment_vm" "k8s_cp_01" {
  name        = "k8s-cp-01"
  description = "Managed by Terraform"
  tags        = ["terraform"]
  node_name   = "pve"

  cpu {
    cores = 2
  }

  memory {
    dedicated = 6144
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_file.debian_cloud_image.id
    interface    = "scsi0"
    size         = 32
  }

  serial_device {} # The Debian cloud image expects a serial port to be present

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = "local-lvm"
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "k8s_worker" {
  count       = length(var.name_count)
  name        = "${var.name_count[count.index]}"
  description = "K8S Worker Managed by Terraform"
  tags        = ["terraform worker"]
  node_name   = "pve"

  cpu {
    cores = 1
  }

  memory {
    dedicated = 4096
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_file.debian_cloud_image.id
    interface    = "scsi0"
    size         = 50
  }

  serial_device {} # The Debian cloud image expects a serial port to be present

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = "local-lvm"
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
    dns {
      server = "8.8.8.8"
      domain = "8.8.8.8"
    }
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }
}

# resource "proxmox_virtual_environment_vm" "k8s_worker_02" {
#   name        = "k8s-worker-02"
#   description = "Managed by Terraform"
#   tags        = ["terraform"]
#   node_name   = "pve"

#   cpu {
#     cores = 1
#   }

#   memory {
#     dedicated = 2048
#   }

#   agent {
#     enabled = true
#   }

#   network_device {
#     bridge = "vmbr0"
#   }

#   disk {
#     datastore_id = "local-lvm"
#     file_id      = proxmox_virtual_environment_file.debian_cloud_image.id
#     interface    = "scsi0"
#     size         = 32
#   }

#   serial_device {} # The Debian cloud image expects a serial port to be present

#   operating_system {
#     type = "l26" # Linux Kernel 2.6 - 5.X.
#   }

#   initialization {
#     datastore_id = "local-lvm"
#     user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
#     ip_config {
#       ipv4 {
#         address = "dhcp"
#       }
#     }
#   }
# }