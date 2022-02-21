# frozen_string_literal: true

module SFRest
  # We need to keep this naming due to the way connection.rb autoloads things.
  # rubocop: disable Naming/ClassAndModuleCamelCase
  # Manage the customer standard domain feature.
  class Customer_standard_domain
    # rubocop: enable Naming/ClassAndModuleCamelCase

    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get current customer standard domains settings
    #
    # @return [Array] an array of customer standard domains with their associated settings.
    def customer_standard_domain_mapping
      @conn.get('/api/v1/customer-standard-domains')
    end

    # Enable the customer standard domains settings for a given template name.
    # @param [String] domain_template_name the domain template name.
    # @param [Array] new_template the templates to be used.
    #
    # @return [Array] an array of customer standard domains with their associated settings.
    def enable_customer_standard_domain_template(domain_template_name, new_template = [])
      payload = {
        'new_template' => new_template
      }.to_json
      @conn.put("/api/v1/customer-standard-domains/#{domain_template_name}", payload)
    end

    # Disable the centralized role management settings for a given role.
    # @param [String] domain_template_name the domain template name.
    #
    # @return [Array] an array of customer standard domains with their associated settings.
    def disable_customer_standard_domain_template(domain_template_name)
      @conn.delete("/api/v1/customer-standard-domains/#{domain_template_name}")
    end

    # Backfills the customer standard domains using the templates defined.
    #
    # @return [Array] an array containing the message and task_id for that operation.
    def backfill_domains
      @conn.post('/api/v1/customer-standard-domains', {}.to_json)
    end
  end
end
