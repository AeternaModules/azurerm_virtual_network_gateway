resource "azurerm_virtual_network_gateway" "virtual_network_gateways" {
  for_each = var.virtual_network_gateways

  location                              = each.value.location
  name                                  = each.value.name
  resource_group_name                   = each.value.resource_group_name
  sku                                   = each.value.sku
  type                                  = each.value.type
  tags                                  = each.value.tags
  remote_vnet_traffic_enabled           = each.value.remote_vnet_traffic_enabled
  private_ip_address_enabled            = each.value.private_ip_address_enabled
  minimum_scale_unit                    = each.value.minimum_scale_unit
  maximum_scale_unit                    = each.value.maximum_scale_unit
  ip_sec_replay_protection_enabled      = each.value.ip_sec_replay_protection_enabled
  generation                            = each.value.generation
  edge_zone                             = each.value.edge_zone
  virtual_wan_traffic_enabled           = each.value.virtual_wan_traffic_enabled
  dns_forwarding_enabled                = each.value.dns_forwarding_enabled
  default_local_network_gateway_id      = each.value.default_local_network_gateway_id
  bgp_route_translation_for_nat_enabled = each.value.bgp_route_translation_for_nat_enabled
  bgp_enabled                           = each.value.bgp_enabled
  active_active                         = each.value.active_active
  enable_bgp                            = each.value.enable_bgp
  vpn_type                              = each.value.vpn_type

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      subnet_id                     = ip_configuration.value.subnet_id
    }
  }

  dynamic "bgp_settings" {
    for_each = each.value.bgp_settings != null ? [each.value.bgp_settings] : []
    content {
      asn         = bgp_settings.value.asn
      peer_weight = bgp_settings.value.peer_weight
      dynamic "peering_addresses" {
        for_each = bgp_settings.value.peering_addresses != null ? bgp_settings.value.peering_addresses : []
        content {
          apipa_addresses       = peering_addresses.value.apipa_addresses
          ip_configuration_name = peering_addresses.value.ip_configuration_name
        }
      }
    }
  }

  dynamic "custom_route" {
    for_each = each.value.custom_route != null ? [each.value.custom_route] : []
    content {
      address_prefixes = custom_route.value.address_prefixes
    }
  }

  dynamic "policy_group" {
    for_each = each.value.policy_group != null ? each.value.policy_group : []
    content {
      is_default = policy_group.value.is_default
      name       = policy_group.value.name
      dynamic "policy_member" {
        for_each = policy_group.value.policy_member
        content {
          name  = policy_member.value.name
          type  = policy_member.value.type
          value = policy_member.value.value
        }
      }
      priority = policy_group.value.priority
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = each.value.vpn_client_configuration != null ? [each.value.vpn_client_configuration] : []
    content {
      aad_audience  = vpn_client_configuration.value.aad_audience
      aad_issuer    = vpn_client_configuration.value.aad_issuer
      aad_tenant    = vpn_client_configuration.value.aad_tenant
      address_space = vpn_client_configuration.value.address_space
      dynamic "ipsec_policy" {
        for_each = vpn_client_configuration.value.ipsec_policy != null ? [vpn_client_configuration.value.ipsec_policy] : []
        content {
          dh_group                  = ipsec_policy.value.dh_group
          ike_encryption            = ipsec_policy.value.ike_encryption
          ike_integrity             = ipsec_policy.value.ike_integrity
          ipsec_encryption          = ipsec_policy.value.ipsec_encryption
          ipsec_integrity           = ipsec_policy.value.ipsec_integrity
          pfs_group                 = ipsec_policy.value.pfs_group
          sa_data_size_in_kilobytes = ipsec_policy.value.sa_data_size_in_kilobytes
          sa_lifetime_in_seconds    = ipsec_policy.value.sa_lifetime_in_seconds
        }
      }
      dynamic "radius_server" {
        for_each = vpn_client_configuration.value.radius_server != null ? vpn_client_configuration.value.radius_server : []
        content {
          address = radius_server.value.address
          score   = radius_server.value.score
          secret  = radius_server.value.secret
        }
      }
      radius_server_address = vpn_client_configuration.value.radius_server_address
      radius_server_secret  = vpn_client_configuration.value.radius_server_secret
      dynamic "revoked_certificate" {
        for_each = vpn_client_configuration.value.revoked_certificate != null ? vpn_client_configuration.value.revoked_certificate : []
        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }
      dynamic "root_certificate" {
        for_each = vpn_client_configuration.value.root_certificate != null ? vpn_client_configuration.value.root_certificate : []
        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }
      dynamic "virtual_network_gateway_client_connection" {
        for_each = vpn_client_configuration.value.virtual_network_gateway_client_connection != null ? vpn_client_configuration.value.virtual_network_gateway_client_connection : []
        content {
          address_prefixes   = virtual_network_gateway_client_connection.value.address_prefixes
          name               = virtual_network_gateway_client_connection.value.name
          policy_group_names = virtual_network_gateway_client_connection.value.policy_group_names
        }
      }
      vpn_auth_types       = vpn_client_configuration.value.vpn_auth_types
      vpn_client_protocols = vpn_client_configuration.value.vpn_client_protocols
    }
  }
}

