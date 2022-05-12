#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################  

resource "hcloud_server" "hcloud_kubernetes_controller" {
  name        = "controller.${local.service_name}"
  image       = "debian-11"
  server_type = "cx31"

  location = "fsn1"
  backups  = true

  labels = {
    "service"        = "kubernetes"
    "chainofcommand" = "controller"
    "distribution"   = "debian-11"
  }

  ssh_keys = [var.hcloud_ssh_key_terraform_id]

  // Networks
  network {
    network_id = var.hcloud_network_kubernetes_id
  }

  network {
    network_id = var.hcloud_network_saltstack_id
  }
}

