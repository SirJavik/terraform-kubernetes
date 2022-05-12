#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################  

output "controller_ips" {
  description = "IPs of Kubnertes Controller"

  value = {
    "Hostname" = hcloud_server.hcloud_kubernetes_controller.name
    "IPv4"     = hcloud_server.hcloud_kubernetes_controller.ipv4_address
    "IPv6"     = hcloud_server.hcloud_kubernetes_controller.ipv6_address
  }
}