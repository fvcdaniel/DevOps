locals {
  ansible_hosts = [
    for vm in proxmox_virtual_environment_vm.k8s_worker : 
      "${vm.name} ansible_host=${vm.ipv4_addresses[1][0]} ansible_become=true"
    ]
}
resource "local_file" "ansible_inventory" {
  filename = "./ansible/inventory.ini"
  content     = <<-EOF
  k8s-cp-01 ansible_host=${proxmox_virtual_environment_vm.k8s_cp_01.ipv4_addresses[1][0]} ansible_become=true
  ${join("\n", local.ansible_hosts)}
  [kube_control_plane]
  k8s-cp-01
  [etcd]
  k8s-cp-01
  [kube_node]
  ${join("\n", var.name_count)}
  [k8s_cluster:children]
  kube_node
  kube_control_plane
  EOF

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini --become --become-user=root playbook.yml"
    working_dir = "ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
  }
}