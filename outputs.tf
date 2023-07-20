
output "subnets" {
  value       = module.capstone-subnets.subnets
  description = "The created subnet resources"
}