#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################  

resource "hcloud_server" "hcloud_saltstack_master" {
  name        = "master.${local.service_name}"
  image       = "debian-11"
  server_type = "cx21"

  location = "fsn1"
  backups  = true

  labels = {
    "service"        = "saltstack"
    "chainofcommand" = "master"
    "distribution"   = "debian-11"
  }

  ssh_keys = var.all_ssh_keys_list

  // SETUP

  provisioner "file" {
    source      = abspath("${path.root}/scripts/saltstack-master-init.sh")
    destination = "/tmp/saltstack-master-init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "/usr/bin/echo 'PERFORMING FIRST TIME INSTALL'",
      "/usr/bin/bash /tmp/saltstack-master-init.sh",
      "/usr/bin/echo 'DONE'"
    ]
  }

  connection {
    type        = "ssh"
    user        = "root"
    host        = self.ipv4_address
    port        = 22
    private_key = var.ssh_key
  }
}

resource "hcloud_server_network" "saltmaster_saltstack_network" {
  server_id  = hcloud_server.hcloud_saltstack_master.id
  network_id = var.hcloud_network_saltstack_id
}
