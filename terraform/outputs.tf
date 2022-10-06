output "zookeeper_details" {
  sensitive = true
  description = "Details of the Zookeeper machine"
  value       = module.zookeeper.instance_details
}

output "solr_node_details" {
  sensitive = true
  description = "Details of the solr machines"
  value       = module.solr_node.instance_details
}
