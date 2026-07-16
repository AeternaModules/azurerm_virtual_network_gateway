output "virtual_network_gateways_id" {
  description = "Map of id values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.id if v.id != null && length(v.id) > 0 }
}
output "virtual_network_gateways_active_active" {
  description = "Map of active_active values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.active_active if v.active_active != null }
}
output "virtual_network_gateways_bgp_enabled" {
  description = "Map of bgp_enabled values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.bgp_enabled if v.bgp_enabled != null }
}
output "virtual_network_gateways_bgp_route_translation_for_nat_enabled" {
  description = "Map of bgp_route_translation_for_nat_enabled values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.bgp_route_translation_for_nat_enabled if v.bgp_route_translation_for_nat_enabled != null }
}
output "virtual_network_gateways_bgp_settings" {
  description = "Map of bgp_settings values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.bgp_settings if v.bgp_settings != null && length(v.bgp_settings) > 0 }
}
output "virtual_network_gateways_custom_route" {
  description = "Map of custom_route values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.custom_route if v.custom_route != null && length(v.custom_route) > 0 }
}
output "virtual_network_gateways_default_local_network_gateway_id" {
  description = "Map of default_local_network_gateway_id values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.default_local_network_gateway_id if v.default_local_network_gateway_id != null && length(v.default_local_network_gateway_id) > 0 }
}
output "virtual_network_gateways_dns_forwarding_enabled" {
  description = "Map of dns_forwarding_enabled values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.dns_forwarding_enabled if v.dns_forwarding_enabled != null }
}
output "virtual_network_gateways_edge_zone" {
  description = "Map of edge_zone values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.edge_zone if v.edge_zone != null && length(v.edge_zone) > 0 }
}
output "virtual_network_gateways_enable_bgp" {
  description = "Map of enable_bgp values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.enable_bgp if v.enable_bgp != null }
}
output "virtual_network_gateways_generation" {
  description = "Map of generation values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.generation if v.generation != null && length(v.generation) > 0 }
}
output "virtual_network_gateways_ip_configuration" {
  description = "Map of ip_configuration values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.ip_configuration if v.ip_configuration != null && length(v.ip_configuration) > 0 }
}
output "virtual_network_gateways_ip_sec_replay_protection_enabled" {
  description = "Map of ip_sec_replay_protection_enabled values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.ip_sec_replay_protection_enabled if v.ip_sec_replay_protection_enabled != null }
}
output "virtual_network_gateways_location" {
  description = "Map of location values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.location if v.location != null && length(v.location) > 0 }
}
output "virtual_network_gateways_maximum_scale_unit" {
  description = "Map of maximum_scale_unit values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.maximum_scale_unit if v.maximum_scale_unit != null }
}
output "virtual_network_gateways_minimum_scale_unit" {
  description = "Map of minimum_scale_unit values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.minimum_scale_unit if v.minimum_scale_unit != null }
}
output "virtual_network_gateways_name" {
  description = "Map of name values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.name if v.name != null && length(v.name) > 0 }
}
output "virtual_network_gateways_policy_group" {
  description = "Map of policy_group values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.policy_group if v.policy_group != null && length(v.policy_group) > 0 }
}
output "virtual_network_gateways_private_ip_address_enabled" {
  description = "Map of private_ip_address_enabled values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.private_ip_address_enabled if v.private_ip_address_enabled != null }
}
output "virtual_network_gateways_remote_vnet_traffic_enabled" {
  description = "Map of remote_vnet_traffic_enabled values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.remote_vnet_traffic_enabled if v.remote_vnet_traffic_enabled != null }
}
output "virtual_network_gateways_resource_group_name" {
  description = "Map of resource_group_name values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.resource_group_name if v.resource_group_name != null && length(v.resource_group_name) > 0 }
}
output "virtual_network_gateways_sku" {
  description = "Map of sku values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.sku if v.sku != null && length(v.sku) > 0 }
}
output "virtual_network_gateways_tags" {
  description = "Map of tags values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "virtual_network_gateways_type" {
  description = "Map of type values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.type if v.type != null && length(v.type) > 0 }
}
output "virtual_network_gateways_virtual_wan_traffic_enabled" {
  description = "Map of virtual_wan_traffic_enabled values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.virtual_wan_traffic_enabled if v.virtual_wan_traffic_enabled != null }
}
output "virtual_network_gateways_vpn_client_configuration" {
  description = "Map of vpn_client_configuration values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.vpn_client_configuration if v.vpn_client_configuration != null && length(v.vpn_client_configuration) > 0 }
  sensitive   = true
}
output "virtual_network_gateways_vpn_type" {
  description = "Map of vpn_type values across all virtual_network_gateways, keyed the same as var.virtual_network_gateways"
  value       = { for k, v in azurerm_virtual_network_gateway.virtual_network_gateways : k => v.vpn_type if v.vpn_type != null && length(v.vpn_type) > 0 }
}

