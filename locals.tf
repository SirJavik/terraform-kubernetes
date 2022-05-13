#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################  

locals {
  terraform_ssh_key = [
    hcloud_ssh_key.hcloud_ssh_key_terraform.id
  ]

  kubernetes_ssh_keys_controller = [
    hcloud_ssh_key.hcloud_controller_nodes_ssh_keys.id
  ]

  kubernetes_ssh_keys_nodes = [
    for keys in hcloud_ssh_key.hcloud_kubernetes_nodes_ssh_keys : keys.id
  ]

  kubernetes_all_ssh_keys = concat(local.terraform_ssh_key, local.kubernetes_ssh_keys_controller, local.kubernetes_ssh_keys_nodes)

  private_kubernetes_ssh_keys_nodes = [
    for keys in tls_private_key.kubernetes_nodes_ssh_keys : keys.private_key_openssh
  ]
}