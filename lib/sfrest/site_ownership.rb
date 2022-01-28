# frozen_string_literal: true

module SFRest
  # We need to keep this naming due to the way connection.rb autoloads things.
  # rubocop: disable Naming/ClassAndModuleCamelCase
  # Manage the site default ownership feature.
  class Site_ownership
    # rubocop: enable Naming/ClassAndModuleCamelCase

    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get current site ownership settings.
    #
    # @return [Array] an array containing current settings.
    def default_ownership
      @conn.get('/api/v1/site-ownership')
    end

    # Set the site ownership settings.
    # @param [String] The default owner username. The user has to have the "Platform admin" role.
    #
    # @return [Array] an array containing the message given by the server.
    def make_default_owner(username)
      payload = {
        'username' => username
      }

      @conn.put('/api/v1/site-ownership', payload.to_json)
    end

    # Removes the default site owner.
    #
    # @return [Array] an array containing the message given by the server.
    def remove_default_owner
      @conn.delete('/api/v1/site-ownership')
    end
  end
end
