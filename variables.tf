#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################     

// Cloudflare

variable "cloudflare_api_key" {
  sensitive = true
  type      = string
}

variable "cloudflare_email" {
  sensitive = false
  type      = string
}

// Hetzner

variable "hcloud_token" {
  sensitive = true
  type      = string
}

// Let's Encrypt

variable "acme_server_url" {
  sensitive = false
  default   = "https://acme-staging-v02.api.letsencrypt.org/directory"
  type      = string
}

variable "acme_account_email" {
  sensitive = false
  type      = string
}

// Default

variable "domain" {
  sensitive = false
  default   = "mondbasis24.de"
  type      = string
}

variable "ssh_private_key_terraform" {
  sensitive = false
  type      = string
}



