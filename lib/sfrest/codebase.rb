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
    # { "stacks" => { 1 => {"name" : "abcde", "description": "xyz"} , 2 => {"name":"fghij", "description": "xyzsc" } } }
    def list
      @conn.get('/api/v1/stacks')
    end

    # Edits stack name and description.
    # @param [Integer] stack_id.
    # @param [String] name.
    # @param [String] description.
    #
    # @return [Array] an array containing the message given by the server.
    def edit_stacks(stack_id, name, description)
      payload = {
        'name' => name,
        'description' => description
      }
      @conn.put("/api/v1/stacks/#{stack_id}", payload.to_json)
    end
  end
end
