#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################                                 

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.0"
    }
  }
}

resource "hcloud_network" "hcloud_saltstack_network" {
  name     = "saltstack"
  ip_range = "192.168.100.0/24"
}

resource "hcloud_network_subnet" "hcloud_saltstack_network_subnet" {
  network_id   = hcloud_network.hcloud_saltstack_network.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "192.168.100.0/24"
}

resource "hcloud_network" "hcloud_kubernetes_network" {
  name     = "kubernetes"
  ip_range = "192.168.110.0/24"
}

resource "hcloud_network_subnet" "hcloud_kubernetes_network_subnet" {
  network_id   = hcloud_network.hcloud_kubernetes_network.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "192.168.110.0/24"
}

