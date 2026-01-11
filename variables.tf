variable "virtual_network_gateways" {
  description = <<EOT
Map of virtual_network_gateways, attributes below
Required:
    - location
    - name
    - resource_group_name
    - sku
    - type
    - ip_configuration (block):
        - name (optional)
        - private_ip_address_allocation (optional)
        - public_ip_address_id (optional)
        - subnet_id (required)
Optional:
    - active_active
    - bgp_route_translation_for_nat_enabled
    - default_local_network_gateway_id
    - dns_forwarding_enabled
    - edge_zone
    - enable_bgp
    - generation
    - ip_sec_replay_protection_enabled
    - private_ip_address_enabled
    - remote_vnet_traffic_enabled
    - tags
    - virtual_wan_traffic_enabled
    - vpn_type
    - bgp_settings (block):
        - asn (optional)
        - peer_weight (optional)
        - peering_addresses (optional, block):
            - apipa_addresses (optional)
            - ip_configuration_name (optional)
    - custom_route (block):
        - address_prefixes (optional)
    - policy_group (block):
        - is_default (optional)
        - name (required)
        - policy_member (required, block):
            - name (required)
            - type (required)
            - value (required)
        - priority (optional)
    - vpn_client_configuration (block):
        - aad_audience (optional)
        - aad_issuer (optional)
        - aad_tenant (optional)
        - address_space (required)
        - ipsec_policy (optional, block):
            - dh_group (required)
            - ike_encryption (required)
            - ike_integrity (required)
            - ipsec_encryption (required)
            - ipsec_integrity (required)
            - pfs_group (required)
            - sa_data_size_in_kilobytes (required)
            - sa_lifetime_in_seconds (required)
        - radius_server (optional, block):
            - address (required)
            - score (required)
            - secret (required)
        - radius_server_address (optional)
        - radius_server_secret (optional)
        - revoked_certificate (optional, block):
            - name (required)
            - thumbprint (required)
        - root_certificate (optional, block):
            - name (required)
            - public_cert_data (required)
        - virtual_network_gateway_client_connection (optional, block):
            - address_prefixes (required)
            - name (required)
            - policy_group_names (required)
        - vpn_auth_types (optional)
        - vpn_client_protocols (optional)
EOT

  type = map(object({
    location                              = string
    name                                  = string
    resource_group_name                   = string
    sku                                   = string
    type                                  = string
    tags                                  = optional(map(string))
    remote_vnet_traffic_enabled           = optional(bool, false)
    private_ip_address_enabled            = optional(bool)
    ip_sec_replay_protection_enabled      = optional(bool, true)
    generation                            = optional(string)
    dns_forwarding_enabled                = optional(bool)
    edge_zone                             = optional(string)
    virtual_wan_traffic_enabled           = optional(bool, false)
    default_local_network_gateway_id      = optional(string)
    bgp_route_translation_for_nat_enabled = optional(bool, false)
    active_active                         = optional(bool)
    enable_bgp                            = optional(bool)
    vpn_type                              = optional(string, "RouteBased")
    ip_configuration = list(object({
      name                          = optional(string, "vnetGatewayConfig")
      private_ip_address_allocation = optional(string, "Dynamic")
      public_ip_address_id          = optional(string)
      subnet_id                     = string
    }))
    bgp_settings = optional(object({
      asn         = optional(number)
      peer_weight = optional(number)
      peering_addresses = optional(list(object({
        apipa_addresses       = optional(list(string))
        ip_configuration_name = optional(string)
      })))
    }))
    custom_route = optional(object({
      address_prefixes = optional(set(string))
    }))
    policy_group = optional(object({
      is_default = optional(bool, false)
      name       = string
      policy_member = object({
        name  = string
        type  = string
        value = string
      })
      priority = optional(number, 0)
    }))
    vpn_client_configuration = optional(object({
      aad_audience  = optional(string)
      aad_issuer    = optional(string)
      aad_tenant    = optional(string)
      address_space = list(string)
      ipsec_policy = optional(object({
        dh_group                  = string
        ike_encryption            = string
        ike_integrity             = string
        ipsec_encryption          = string
        ipsec_integrity           = string
        pfs_group                 = string
        sa_data_size_in_kilobytes = number
        sa_lifetime_in_seconds    = number
      }))
      radius_server = optional(object({
        address = string
        score   = number
        secret  = string
      }))
      radius_server_address = optional(string)
      radius_server_secret  = optional(string)
      revoked_certificate = optional(object({
        name       = string
        thumbprint = string
      }))
      root_certificate = optional(object({
        name             = string
        public_cert_data = string
      }))
      virtual_network_gateway_client_connection = optional(object({
        address_prefixes   = list(string)
        name               = string
        policy_group_names = list(string)
      }))
      vpn_auth_types       = optional(set(string))
      vpn_client_protocols = optional(set(string))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        length(v.ip_configuration) <= 3
      )
    ])
    error_message = "Each ip_configuration list must contain at most 3 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.bgp_settings.peering_addresses == null || (length(v.bgp_settings.peering_addresses) >= 1 && length(v.bgp_settings.peering_addresses) <= 2)
      )
    ])
    error_message = "Each peering_addresses list must contain between 1 and 2 items"
  }
}

