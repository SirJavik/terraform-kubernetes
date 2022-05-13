#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################     

// Let's Encrypt Account Setup

resource "tls_private_key" "acme_account_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "acme_registration" "acme_account_registration" {
  account_key_pem = tls_private_key.acme_account_private_key.private_key_pem
  email_address   = var.acme_account_email
}

// SSH Keys

//// Hetzner

resource "hcloud_ssh_key" "hcloud_ssh_key_terraform" {
  name       = "Terraform"
  public_key = file("${var.ssh_private_key_terraform}.pub")

}


///// Kubernetes Nodes
resource "tls_private_key" "kubernetes_nodes_ssh_keys" {
  count     = var.kubernetes_nodes_count
  algorithm = "ED25519"
}

resource "hcloud_ssh_key" "hcloud_kubernetes_nodes_ssh_keys" {
  count      = length(tls_private_key.kubernetes_nodes_ssh_keys)
  name       = "Kubernetes Node ${count.index + 1}"
  public_key = tls_private_key.kubernetes_nodes_ssh_keys[count.index].public_key_openssh
}

//// Kubernetes Controller
resource "tls_private_key" "kubernetes_controller_ssh_keys" {
  algorithm = "ED25519"
}

resource "hcloud_ssh_key" "hcloud_controller_nodes_ssh_keys" {
  name       = "Kubernetes Controller"
  public_key = tls_private_key.kubernetes_controller_ssh_keys.public_key_openssh
}
