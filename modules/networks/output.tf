#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################     

output "hcloud_kubernetes_network_id" {
  description = "ID of the kubernetes network"

  value = hcloud_network.hcloud_kubernetes_network.id
}

output "hcloud_saltstack_network_id" {
  description = "ID of the saltstack network"

  value = hcloud_network.hcloud_saltstack_network.id
}

