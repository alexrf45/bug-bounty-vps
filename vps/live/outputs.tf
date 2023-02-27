output "public_ip" {
  value       = module.vps.new_public_ip
  description = "The IP of the VPS"
}
