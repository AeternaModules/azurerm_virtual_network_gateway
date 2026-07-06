output "virtual_network_gateways" {
  description = "All virtual_network_gateway resources"
  value       = azurerm_virtual_network_gateway.virtual_network_gateways
  sensitive   = true
}
output "virtual_network_gateways_active_active" {
  description = "List of active_active values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.active_active]
}
output "virtual_network_gateways_bgp_enabled" {
  description = "List of bgp_enabled values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.bgp_enabled]
}
output "virtual_network_gateways_bgp_route_translation_for_nat_enabled" {
  description = "List of bgp_route_translation_for_nat_enabled values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.bgp_route_translation_for_nat_enabled]
}
output "virtual_network_gateways_bgp_settings" {
  description = "List of bgp_settings values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.bgp_settings]
}
output "virtual_network_gateways_custom_route" {
  description = "List of custom_route values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.custom_route]
}
output "virtual_network_gateways_default_local_network_gateway_id" {
  description = "List of default_local_network_gateway_id values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.default_local_network_gateway_id]
}
output "virtual_network_gateways_dns_forwarding_enabled" {
  description = "List of dns_forwarding_enabled values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.dns_forwarding_enabled]
}
output "virtual_network_gateways_edge_zone" {
  description = "List of edge_zone values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.edge_zone]
}
output "virtual_network_gateways_enable_bgp" {
  description = "List of enable_bgp values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.enable_bgp]
}
output "virtual_network_gateways_generation" {
  description = "List of generation values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.generation]
}
output "virtual_network_gateways_ip_configuration" {
  description = "List of ip_configuration values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.ip_configuration]
}
output "virtual_network_gateways_ip_sec_replay_protection_enabled" {
  description = "List of ip_sec_replay_protection_enabled values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.ip_sec_replay_protection_enabled]
}
output "virtual_network_gateways_location" {
  description = "List of location values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.location]
}
output "virtual_network_gateways_maximum_scale_unit" {
  description = "List of maximum_scale_unit values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.maximum_scale_unit]
}
output "virtual_network_gateways_minimum_scale_unit" {
  description = "List of minimum_scale_unit values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.minimum_scale_unit]
}
output "virtual_network_gateways_name" {
  description = "List of name values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.name]
}
output "virtual_network_gateways_policy_group" {
  description = "List of policy_group values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.policy_group]
}
output "virtual_network_gateways_private_ip_address_enabled" {
  description = "List of private_ip_address_enabled values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.private_ip_address_enabled]
}
output "virtual_network_gateways_remote_vnet_traffic_enabled" {
  description = "List of remote_vnet_traffic_enabled values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.remote_vnet_traffic_enabled]
}
output "virtual_network_gateways_resource_group_name" {
  description = "List of resource_group_name values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.resource_group_name]
}
output "virtual_network_gateways_sku" {
  description = "List of sku values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.sku]
}
output "virtual_network_gateways_tags" {
  description = "List of tags values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.tags]
}
output "virtual_network_gateways_type" {
  description = "List of type values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.type]
}
output "virtual_network_gateways_virtual_wan_traffic_enabled" {
  description = "List of virtual_wan_traffic_enabled values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.virtual_wan_traffic_enabled]
}
output "virtual_network_gateways_vpn_client_configuration" {
  description = "List of vpn_client_configuration values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.vpn_client_configuration]
  sensitive   = true
}
output "virtual_network_gateways_vpn_type" {
  description = "List of vpn_type values across all virtual_network_gateways"
  value       = [for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : v.vpn_type]
}

