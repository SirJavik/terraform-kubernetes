#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################  

resource "hcloud_server" "hcloud_kubernetes_node" {
  count       = 4
  name        = "node${count.index + 1}.${local.service_name}"
  image       = "debian-11"
  server_type = "cx11"

  location = "fsn1"
  backups  = true

  labels = {
    "service"        = "kubernetes"
    "chainofcommand" = "controller"
    "distribution"   = "debian-11"
  }

  ssh_keys = [var.terraform_ssh_key_id]

  // Networks
  network {
    network_id = var.hcloud_network_kubernetes_id
  }

  network {
    network_id = var.hcloud_network_saltstack_id
  }

  // SETUP

  user_data = templatefile(abspath("${path.root}/scripts/cloud-init/salt-minion.yml"), {
    saltmaster_ip = var.saltmaster_ip
  })

  provisioner "remote-exec" {
    inline = [
      "/usr/bin/mkdir -pv /root/.ssh",
      "/usr/bin/printf \"${var.nodes_private_ssh_keys[count.index]}\" > /root/.ssh/private_key",
      "/usr/bin/chmod 0600 /root/.ssh/private_key",
      "/usr/bin/ssh -oStrictHostKeyChecking=accept-new -i /root/.ssh/private_key root@${var.saltmaster_ip} \"/usr/bin/salt-key -y -q -A\""
    ]
  }

  connection {
    type        = "ssh"
    user        = "root"
    host        = self.ipv4_address
    port        = 22
    private_key = var.ssh_key
  }

  depends_on = [
    hcloud_server.hcloud_kubernetes_controller
  ]
}

