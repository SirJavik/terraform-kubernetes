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
