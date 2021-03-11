# frozen_string_literal: true

module SFRest
  # Work with installation profiles.
  class Profile
    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Gets a list of installation profiles.
    #
    # @param [Hash] params Given as URL parameters.
    # @option params [Integer] :stack_id A stack id to filter by.
    # @option params [Boolean] :is_enabled True to filter by enabled profiles. False
    #   to filter by disabled profiles.
    # @return [Hash] Profile info formatted like so: {
    #     'profiles' => [{
    #       'name' => 'testing',
    #       'description' => 'Some description',
    #       'stack_id' => 1,
    #       'rest_api_default' => false,
    #       'enabled' => true
    #     }],
    #     'count' => 1,
    #     'time' => '2021-03-12T02:26:34+00:00'
    #   }
    def profile_list(**params)
      target_url = '/api/v1/profiles'
      # Generate a string like "stack_id=3&is_enabled=true"
      url_params = params.each.map { |k, v| "#{k}=#{v}" }.join('&')
      target_url += "?#{url_params}" unless url_params.empty?

      # Output is already well-formed, so return it.
      @conn.get(target_url)
    end

    # Enables an installation profile.
    #
    # @param [String] name
    # @param [Integer] stack_id Required if the factory is multistack.
    def enable(name, stack_id: nil)
      target_url = "/api/v1/profiles/#{name}/enable"
      target_url += "?stack_id=#{stack_id}" unless stack_id.nil?
      @conn.post(target_url, '{}')
    end

    # Disables an installation profile.
    #
    # @param [String] name
    # @param [Integer] stack_id Required if the factory is multistack.
    def disable(name, stack_id: nil)
      target_url = "/api/v1/profiles/#{name}/disable"
      target_url += "?stack_id=#{stack_id}" unless stack_id.nil?
      @conn.post(target_url, '{}')
    end

    # Sets the default installation profile for use with other REST endpoints.
    #
    # @param [String] name
    # @param [Integer] stack_id Required if the factory is multistack.
    def set_default(name, stack_id: nil)
      target_url = "/api/v1/profiles/#{name}/set_default"
      target_url += "?stack_id=#{stack_id}" unless stack_id.nil?
      @conn.post(target_url, '{}')
    end
  end
end
