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
    remote_vnet_traffic_enabled           = optional(bool) # Default: false
    private_ip_address_enabled            = optional(bool)
    minimum_scale_unit                    = optional(number)
    maximum_scale_unit                    = optional(number)
    ip_sec_replay_protection_enabled      = optional(bool) # Default: true
    generation                            = optional(string)
    edge_zone                             = optional(string)
    virtual_wan_traffic_enabled           = optional(bool) # Default: false
    dns_forwarding_enabled                = optional(bool)
    default_local_network_gateway_id      = optional(string)
    bgp_route_translation_for_nat_enabled = optional(bool) # Default: false
    bgp_enabled                           = optional(bool)
    active_active                         = optional(bool)
    enable_bgp                            = optional(bool)
    vpn_type                              = optional(string) # Default: "RouteBased"
    ip_configuration = list(object({
      name                          = optional(string) # Default: "vnetGatewayConfig"
      private_ip_address_allocation = optional(string) # Default: "Dynamic"
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
      is_default = optional(bool) # Default: false
      name       = string
      policy_member = list(object({
        name  = string
        type  = string
        value = string
      }))
      priority = optional(number) # Default: 0
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
        length(v.ip_configuration) <= 3
      )
    ])
    error_message = "Each ip_configuration list must contain at most 3 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_gateways : (
        v.bgp_settings == null || (v.bgp_settings.peering_addresses == null || (length(v.bgp_settings.peering_addresses) >= 1 && length(v.bgp_settings.peering_addresses) <= 2))
      )
    ])
    error_message = "Each peering_addresses list must contain between 1 and 2 items"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_virtual_network_gateway's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: resource_group_name
  #   condition: length(value) <= 90
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) > 90]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) > 90]
  # path: resource_group_name
  #   condition: !endswith(value, ".")
  #   message:   [from resourcegroups.ValidateName: must not end with "."]
  #   source:    [from resourcegroups.ValidateName: must not end with "."]
  # path: resource_group_name
  #   condition: length(value) != 0
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) == 0]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) == 0]
  # path: resource_group_name
  #   source:    [from resourcegroups.ValidateName] !matched
  # path: location
  #   source:    location.EnhancedValidate: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: edge_zone
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: sku
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: generation
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: ip_configuration.private_ip_address_allocation
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: ip_configuration.subnet_id
  #   source:    [from validate.IsGatewaySubnet] !ok
  # path: ip_configuration.subnet_id
  #   source:    [from validate.IsGatewaySubnet] err != nil
  # path: ip_configuration.subnet_id
  #   source:    [from validate.IsGatewaySubnet] !strings.EqualFold(id.SubnetName, "GatewaySubnet")
  # path: ip_configuration.public_ip_address_id
  #   source:    [from commonids.ValidatePublicIPAddressID] !ok
  # path: ip_configuration.public_ip_address_id
  #   source:    [from commonids.ValidatePublicIPAddressID] err != nil
  # path: policy_group.name
  #   source:    validate.PolicyGroupName: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: policy_group.policy_member.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: policy_group.policy_member.type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: policy_group.policy_member.value
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: policy_group.priority
  #   condition: value >= 0
  #   message:   must be at least 0
  # path: vpn_client_configuration.virtual_network_gateway_client_connection.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: vpn_client_configuration.virtual_network_gateway_client_connection.policy_group_names[*]
  #   source:    validate.PolicyGroupName: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: vpn_client_configuration.virtual_network_gateway_client_connection.address_prefixes[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: vpn_client_configuration.ipsec_policy.dh_group
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_client_configuration.ipsec_policy.ike_encryption
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_client_configuration.ipsec_policy.ike_integrity
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_client_configuration.ipsec_policy.ipsec_encryption
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_client_configuration.ipsec_policy.ipsec_integrity
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_client_configuration.ipsec_policy.pfs_group
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_client_configuration.ipsec_policy.sa_lifetime_in_seconds
  #   condition: value >= 300 && value <= 172799
  #   message:   must be between 300 and 172799
  # path: vpn_client_configuration.ipsec_policy.sa_data_size_in_kilobytes
  #   source:    validation.IntBetween(1024, math.MaxInt32) - bound(s) not a literal int (e.g. a named constant like math.MaxInt32) - resolve manually
  # path: vpn_client_configuration.radius_server.address
  #   source:    validation.IsIPv4Address(...) - no translation rule yet, add one
  # path: vpn_client_configuration.radius_server.secret
  #   condition: length(value) >= 1 && length(value) <= 128
  #   message:   must be between 1 and 128 characters
  # path: vpn_client_configuration.radius_server.score
  #   condition: value >= 1 && value <= 30
  #   message:   must be between 1 and 30
  # path: vpn_client_configuration.radius_server_address
  #   source:    validation.IsIPv4Address(...) - no translation rule yet, add one
  # path: vpn_client_configuration.vpn_auth_types[*]
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_client_configuration.vpn_client_protocols[*]
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: bgp_settings.peering_addresses.ip_configuration_name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: bgp_settings.peering_addresses.apipa_addresses[*]
  #   source:    [from validate.IPAddressInAzureReservedAPIPARange] !ok
  # path: bgp_settings.peering_addresses.apipa_addresses[*]
  #   source:    [from validate.IPAddressInAzureReservedAPIPARange] four == nil
  # path: bgp_settings.peering_addresses.apipa_addresses[*]
  #   source:    [from validate.IPAddressInAzureReservedAPIPARange] bytes.Compare(ip, azureAPIPAStart) < 0 || bytes.Compare(ip, azureAPIPAEnd) > 0
  # path: default_local_network_gateway_id
  #   source:    [from localnetworkgateways.ValidateLocalNetworkGatewayID] !ok
  # path: default_local_network_gateway_id
  #   source:    [from localnetworkgateways.ValidateLocalNetworkGatewayID] err != nil
  # path: maximum_scale_unit
  #   condition: value >= 1 && value <= 40
  #   message:   must be between 1 and 40
  # path: minimum_scale_unit
  #   condition: value >= 1 && value <= 40
  #   message:   must be between 1 and 40
  # path: tags
  #   condition: length(value) <= 50
  #   message:   [from tags.Validate: invalid when len(value) > 50]
  #   source:    [from tags.Validate: invalid when len(value) > 50]
  # path: tags
  #   condition: length(value) <= 512
  #   message:   [from tags.Validate: invalid when len(value) > 512]
  #   source:    [from tags.Validate: invalid when len(value) > 512]
  # path: tags
  #   source:    [from tags.Validate] err != nil
  # path: tags
  #   condition: length(value) <= 256
  #   message:   [from tags.Validate: invalid when len(value) > 256]
  #   source:    [from tags.Validate: invalid when len(value) > 256]
}

