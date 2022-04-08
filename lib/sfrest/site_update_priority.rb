# frozen_string_literal: true

module SFRest
  # We need to keep this naming due to the way connection.rb autoloads things.
  # rubocop: disable Naming/ClassAndModuleCamelCase
  # Manage the site update priority feature.
  class Site_update_priority
    # rubocop: enable Naming/ClassAndModuleCamelCase

    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get current site update priority.
    #
    # @return [Array] an array of the current site update priority.
    def current_update_priority
      @conn.get('/api/v1/site-update-priority')
    end

    # Set the site update priority list.
    # @param [Array] site node ids in the desired update order.
    #
    # @return [Array] an array containing the message given by the server.
    def change_update_priority(priority)
      payload = {
        'priority' => priority
      }.to_json
      @conn.put('/api/v1/site-update-priority', payload)
    end

    # Reset the site update priority to the default.
    #
    # @return [Array] an array containing the message given by the server.
    def reset_update_priority
      @conn.delete('/api/v1/site-update-priority')
    end
  end
end
