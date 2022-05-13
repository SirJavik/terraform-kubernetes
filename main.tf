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

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }

    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "acme" {
  server_url = var.acme_server_url
}

// Local modules

module "networks" {
  source = "./modules/networks"
}

module "kubernetes" {
  source = "./modules/kubernetes"

  // Variables
  terraform_ssh_key_id         = hcloud_ssh_key.hcloud_ssh_key_terraform.id
  domain                       = var.domain
  hcloud_network_kubernetes_id = module.networks.hcloud_kubernetes_network_id

  hcloud_network_saltstack_id = module.networks.hcloud_saltstack_network_id
  kubernetes_node_count       = var.kubernetes_nodes_count
  ssh_key                     = file(abspath("${path.root}/${var.ssh_private_key_terraform}"))

  saltmaster_ip              = module.saltstack.saltmaster_ip
  controller_private_ssh_key = tls_private_key.kubernetes_controller_ssh_keys.private_key_openssh
  nodes_private_ssh_keys     = local.private_kubernetes_ssh_keys_nodes

  depends_on = [
    module.saltstack,
    module.networks
  ]
}

module "saltstack" {
  source = "./modules/saltstack"

  // Variables
  all_ssh_keys_list           = local.kubernetes_all_ssh_keys
  domain                      = var.domain
  hcloud_network_saltstack_id = module.networks.hcloud_saltstack_network_id
  ssh_key                     = file(abspath("${path.root}/${var.ssh_private_key_terraform}"))

  depends_on = [
    module.networks
  ]
}


