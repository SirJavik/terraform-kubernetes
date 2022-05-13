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

variable "domain" {
  sensitive = false
  type      = string
}

variable "subdomain" {
  sensitive = false
  default   = "saltstack"
  type      = string
}

variable "ssh_key" {
  sensitive = false
  type      = string
}

variable "all_ssh_keys_list" {
  type      = list(number)
  sensitive = false
}

variable "hcloud_network_saltstack_id" {
  type      = number
  sensitive = false
}


