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
  default   = "kubernetes"
  type      = string
}

variable "ssh_key" {
  sensitive = false
  type      = string
}

variable "terraform_ssh_key_id" {
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

// Kubernetes

variable "kubernetes_node_count" {
  type      = number
  sensitive = false
}

// Saltstack

variable "saltmaster_ip" {
  type      = string
  sensitive = false
}

// SSH Keys

variable "controller_private_ssh_key" {
  type      = string
  sensitive = true
}

variable "nodes_private_ssh_keys" {
  type      = list(string)
  sensitive = true
}
