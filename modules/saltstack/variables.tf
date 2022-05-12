#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################     

// Defaults

// Defaults

variable "domain" {
  sensitive = false
  type      = string
}

variable "subdomain" {
  sensitive = false
  default   = "saltstack"
  type      = string
}

variable "hcloud_ssh_key_terraform_id" {
  type      = number
  sensitive = false
}

variable "hcloud_network_kubernetes_id" {
  type      = number
  sensitive = false
}

variable "hcloud_network_saltstack_id" {
  type      = number
  sensitive = false
}
