#########################################
#            _             _ _          #
#           | |           (_) |         #
#           | | __ ___   ___| | __      #
#       _   | |/ _` \ \ / / | |/ /      #
#      | |__| | (_| |\ V /| |   <       #
#       \____/ \__,_| \_/ |_|_|\_\      #
#                                       #
#########################################  

output "kubernetes_controller_ips" {
  description = "IPs of Kubernetes Controller"
  value       = module.kubernetes.controller_ips
}

