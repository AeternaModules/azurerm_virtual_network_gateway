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
    - bgp_enabled
    - bgp_route_translation_for_nat_enabled
    - default_local_network_gateway_id
    - dns_forwarding_enabled
    - edge_zone
    - enable_bgp
    - generation
    - ip_sec_replay_protection_enabled
    - maximum_scale_unit
    - minimum_scale_unit
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
    remote_vnet_traffic_enabled           = optional(bool)
    private_ip_address_enabled            = optional(bool)
    minimum_scale_unit                    = optional(number)
    maximum_scale_unit                    = optional(number)
    ip_sec_replay_protection_enabled      = optional(bool)
    generation                            = optional(string)
    edge_zone                             = optional(string)
    virtual_wan_traffic_enabled           = optional(bool)
    dns_forwarding_enabled                = optional(bool)
    default_local_network_gateway_id      = optional(string)
    bgp_route_translation_for_nat_enabled = optional(bool)
    bgp_enabled                           = optional(bool)
    active_active                         = optional(bool)
    enable_bgp                            = optional(bool)
    vpn_type                              = optional(string)
    ip_configuration = list(object({
      name                          = optional(string)
      private_ip_address_allocation = optional(string)
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
    policy_group = optional(list(object({
      is_default = optional(bool)
      name       = string
      policy_member = list(object({
        name  = string
        type  = string
        value = string
      }))
      priority = optional(number)
    })))
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
      radius_server = optional(list(object({
        address = string
        score   = number
        secret  = string
      })))
      radius_server_address = optional(string)
      radius_server_secret  = optional(string)
      revoked_certificate = optional(list(object({
        name       = string
        thumbprint = string
      })))
      root_certificate = optional(list(object({
        name             = string
        public_cert_data = string
      })))
      virtual_network_gateway_client_connection = optional(list(object({
        address_prefixes   = list(string)
        name               = string
        policy_group_names = list(string)
      })))
      vpn_auth_types       = optional(set(string))
      vpn_client_protocols = optional(set(string))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        length(v.ip_configuration) >= 1 && length(v.ip_configuration) <= 3
      )
    ])
    error_message = "Each ip_configuration list must contain between 1 and 3 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.bgp_settings == null || (v.bgp_settings.peering_addresses == null || (length(v.bgp_settings.peering_addresses) <= 2))
      )
    ])
    error_message = "Each peering_addresses list must contain at most 2 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.policy_group == null || alltrue([for item in v.policy_group : (length(item.policy_member) >= 1)])
      )
    ])
    error_message = "Each policy_member list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        length(v.name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.edge_zone == null || (length(v.edge_zone) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.policy_group == null || alltrue([for item in v.policy_group : (alltrue([for item in item.policy_member : (length(item.name) > 0)]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.policy_group == null || alltrue([for item in v.policy_group : (alltrue([for item in item.policy_member : (length(item.value) > 0)]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.policy_group == null || alltrue([for item in v.policy_group : (item.priority == null || (item.priority >= 0))])
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.vpn_client_configuration == null || (v.vpn_client_configuration.virtual_network_gateway_client_connection == null || alltrue([for item in v.vpn_client_configuration.virtual_network_gateway_client_connection : (length(item.name) > 0)]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.vpn_client_configuration == null || (v.vpn_client_configuration.virtual_network_gateway_client_connection == null || alltrue([for item in v.vpn_client_configuration.virtual_network_gateway_client_connection : (alltrue([for x in item.address_prefixes : length(x) > 0]))]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.vpn_client_configuration == null || (v.vpn_client_configuration.ipsec_policy == null || (v.vpn_client_configuration.ipsec_policy.sa_lifetime_in_seconds >= 300 && v.vpn_client_configuration.ipsec_policy.sa_lifetime_in_seconds <= 172799))
      )
    ])
    error_message = "must be between 300 and 172799"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.vpn_client_configuration == null || (v.vpn_client_configuration.radius_server == null || alltrue([for item in v.vpn_client_configuration.radius_server : (length(item.secret) >= 1 && length(item.secret) <= 128)]))
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.vpn_client_configuration == null || (v.vpn_client_configuration.radius_server == null || alltrue([for item in v.vpn_client_configuration.radius_server : (item.score >= 1 && item.score <= 30)]))
      )
    ])
    error_message = "must be between 1 and 30"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.bgp_settings == null || (v.bgp_settings.peering_addresses == null || alltrue([for item in v.bgp_settings.peering_addresses : (item.ip_configuration_name == null || (length(item.ip_configuration_name) > 0))]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.maximum_scale_unit == null || (v.maximum_scale_unit >= 1 && v.maximum_scale_unit <= 40)
      )
    ])
    error_message = "must be between 1 and 40"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.minimum_scale_unit == null || (v.minimum_scale_unit >= 1 && v.minimum_scale_unit <= 40)
      )
    ])
    error_message = "must be between 1 and 40"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.tags == null || (length(v.tags) <= 50)
      )
    ])
    error_message = "[from tags.Validate: invalid when len(value) > 50]"
  }
  # Note: 34 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

