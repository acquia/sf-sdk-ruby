# frozen_string_literal: true

module SFRest
  # List codebases on the factory.
  class Codebase
    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Lists the codebases
    # @return [Hash] A hash of codebases configured for the factory.
    # { "stacks" => { 1 => "abcde", 2 => 'fghij' } }
    def list
      @conn.get('/api/v1/stacks')
    end

    # Edits stack name and description.
    # @param [Integer] stack_id.
    # @param [String] name.
    # @param [String] description.
    # @param [String] tangle_alias.
    #
    # @return [Array] an array containing the message given by the server.
    def edit_stacks(stack_id, name, description, tangle_alias)
      payload = {
        'name' => name,
        'description' => description,
        'tangle_alias' => tangle_alias
      }
      @conn.put("/api/v1/stacks/#{stack_id}", payload.to_json)
    end

    # Lists the codebases with details.
    # @return [Hash] A hash of codebases with details configured for the factory.
    # {"1": {"id": 1, "name": "name", "description": "description", "tangle_alias": "tangle1"} }
    def stacks_with_details
      @conn.get('/api/v1/stacks/details')
    end
  end
end
