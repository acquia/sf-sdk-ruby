# frozen_string_literal: true

module SFRest
  # We need to keep this naming due to the way connection.rb autoloads things.
  # rubocop: disable Naming/ClassAndModuleCamelCase
  # Manage the factory security settings.
  class Security_settings
    # rubocop: enable Naming/ClassAndModuleCamelCase

    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get current security settings.
    #
    # @return [Array] an array containing current security settings.
    def current_security_settings
      @conn.get('/api/v1/security')
    end

    # Change security settings.
    #
    # @param [Hash] datum Options to the security settings
    # @option datum [Integer] 'minimum_password_length'
    # @option datum [String] 'minimum_required_password_strength'
    # @option datum [String] 'two_step_verification'
    # @option datum [String] 'sign_out_inactive_user_accounts'
    # @option datum [Integer] 'sign_out_inactivity_time'
    # @option datum [String] 'automatically_disable_accounts'
    # @option datum [Integer] 'automatically_disable_accounts_after_days'
    #
    # @return [Array] an array containing the message given by the server.
    def change_security_settings(datum)
      @conn.put('/api/v1/security', datum.to_json)
    end

    # Reset current security settings.
    #
    # @return [Array] an array containing the message given by the server.
    def reset_security_settings
      @conn.delete('/api/v1/security')
    end
  end
end
