# frozen_string_literal: true

module SFRest
  # We need to keep this naming due to the way  connection.rb autoloads things.
  # rubocop: disable Naming/ClassAndModuleCamelCase
  # Manage the centralized role management feature.
  class Centralized_role_management
    # rubocop: enable Naming/ClassAndModuleCamelCase

    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get current centralized role management settings
    #
    # @return [Array] an array of roles with their associated settings.
    def centralized_role_mapping
      @conn.get('/api/v1/centralized-role-management')
    end

    # Enable the centralized role management settings for a given role.
    # @param [String] factory_role the site factory role.
    # @param [String] site_role the corresponding role on the site.
    #
    # @return [Array] an array of roles with their associated settings.
    def enable_role_mapping(factory_role, site_role = '')
      payload = {
        'site_role' => site_role
      }.to_json
      @conn.put("/api/v1/centralized-role-management/#{factory_role}", payload)
    end

    # Disable the centralized role management settings for a given role.
    # @param [String] factory_role the site factory role.
    #
    # @return [Array] an array of roles with their associated settings.
    def disable_role_mapping(factory_role)
      @conn.delete("/api/v1/centralized-role-management/#{factory_role}")
    end
  end
end
