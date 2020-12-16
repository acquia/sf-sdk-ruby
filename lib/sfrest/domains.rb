# frozen_string_literal: true

module SFRest
  # Find Staging envs and stage a set of sites
  class Domains
    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get the domains information on a node
    # @param [Integer] node_id The id of the node.
    #
    # @return [Hash] { "node_id" => 4966, "node_type" => "site",
    #  "time" => "2016-11-18T20:09:55+00:00",
    #  "domains" => { "protected_domains" =>[ "it252garden4.utest.sfdev.acquia-test.co" ],
    #  "custom_domains" => [ "it252coll3.utest.sfdev.acquia-test.co", "sc1.nikgregory.us" ] } }
    def get(node_id)
      current_path = "/api/v1/domains/#{node_id}"
      @conn.get(current_path)
    end

    # Get the custom domains on a node
    # @param [Integer] node_id The id of the node.
    #
    # @return [Array] custom(removable) domains on a node
    def custom_domains(node_id)
      get(node_id)['domains']['custom_domains']
    end

    # Get the protetect domains on a node
    # @param [Integer] node_id The id of the node.
    #
    # @return [Array] protected (non-removable) domains on a node
    def protected_domains(node_id)
      get(node_id)['domains']['protected_domains']
    end

    # Add a domain
    # @param [Integer] node_id The id of the node to which add a domain
    # @param [String] domain_name domain to add. e.g. www.example.com
    #
    # @return [Hash] {  "node_type": "site_collection",
    #  "domain": "www.example.com",
    #  "added": true,
    #  "messages": [  "Your domain name was successfully added to the site collection."] }
    def add(node_id, domain_name)
      payload = { 'domain_name' => domain_name }.to_json
      @conn.post("/api/v1/domains/#{node_id}/add", payload)
    end

    # Remove a domain
    # @param [Integer] node_id The id of the node to which remove a domain
    # @param [String] domain_name domain to remove. e.g. www.example.com
    #
    # @return [Hash] {  "node_type": "site_collection",
    #   "domain": "www.example.com",
    #   "removed": true,
    #   "messages": [ "Your domain name was successfully removed from the site collection." ] }
    def remove(node_id, domain_name)
      payload = { 'domain_name' => domain_name }.to_json
      @conn.post("/api/v1/domains/#{node_id}/remove", payload)
    end

    # Get domain status
    # @param [String] domain_name domain to remove. e.g. www.example.com
    #
    # @return [Hash] {  "message" => "The domain is associated with the node.",
    #   "is_domain_associated" => TRUE,
    #   "node_id" => 123,
    #   "node_type" => "site",
    #   "time" => "2016-10-28T09:25:26+00:00",
    #   "stack_id" => 1,
    #   "domains" => array(
    #      "protected_domains" => array('site.example.sfdev.acquia-test.co'),
    #       "custom_domains" => array('www.abc.com/def', 'www.xyz.com'),
    #   ) }
    def status(domain_name)
      @conn.get("/api/v1/domains/status/#{domain_name}")
    end
  end
end
