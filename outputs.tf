
output "subnets" {
  value       = module.capstone-subnets.subnets
  description = "The created subnet resources"
}


output "instances_details" {
  description = "List of all details for compute instances"
  value       = module.compute_instance.instances_details
  sensitive   = true
}