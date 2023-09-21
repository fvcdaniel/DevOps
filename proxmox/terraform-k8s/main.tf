resource "proxmox_virtual_environment_dns" "k8s_cp_01_dns_configuration" {
  domain    = data.proxmox_virtual_environment_dns.k8s_cp_01_dns_configuration.domain
  node_name = data.proxmox_virtual_environment_dns.k8s_cp_01_dns_configuration.node_name

  servers = [
    "1.1.1.1",
    "8.8.8.8",
    "192.168.15.1",
  ]
}
data "proxmox_virtual_environment_dns" "k8s_cp_01_dns_configuration" {
  node_name = "pve"
}

output "instance_id" {
  value = "${join(",", proxmox_virtual_environment_vm.k8s_worker.*.id)}"
}