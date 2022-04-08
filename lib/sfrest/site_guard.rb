# frozen_string_literal: true

module SFRest
  # We need to keep this naming due to the way connection.rb autoloads things.
  # rubocop: disable Naming/ClassAndModuleCamelCase
  # Manage the site guard feature.
  class Site_guard
    # rubocop: enable Naming/ClassAndModuleCamelCase

    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get current site guard settings.
    #
    # @return [Array] an array containing current settings.
    def current_settings
      @conn.get('/api/v1/site-guard')
    end

    # Set and enables the site guard settings.
    # @param [String] The message which will be displayed by the site guard.
    # @param [String] The username which will be required by the site guard.
    # @param [String] The password which will be required by the site guard.
    #
    # @return [Array] an array containing the message given by the server.
    def enable_site_guard(message, username, password)
      payload = {
        'message' => message,
        'username' => username,
        'password' => password
      }

      @conn.put('/api/v1/site-guard', payload.to_json)
    end

    # Removes and disableds the site guard settings.
    #
    # @return [Array] an array containing the message given by the server.
    def disable_site_guard
      @conn.delete('/api/v1/site-guard')
    end
  end
end
