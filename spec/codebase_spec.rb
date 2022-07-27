# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Codebase do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#list' do
    path = '/api/v1/stacks'

    it 'calls the dynamic requests endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.codebase.list
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end
  end

  describe '#edit_stack_name_and_description' do
    id = 1
    path = "/api/v1/stacks/#{id}"

    it 'calls the stacks put endpoint to edit name and description' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.codebase.edit_stacks(id, 'new-name', 'new-description')
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'put'
      expect(JSON(res['body'])['name']).to eq 'new-name'
      expect(JSON(res['body'])['description']).to eq 'new-description'
    end
  end
end
