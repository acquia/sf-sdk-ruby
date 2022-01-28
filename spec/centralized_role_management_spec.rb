# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Centralized_role_management do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#get_current_role_mappings' do
    path = '/api/v1/centralized-role-management'

    it 'calls the centralized role management endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.centralized_role_management.centralized_role_mapping
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end
  end

  describe '#enable_role_mappings' do
    path = '/api/v1/centralized-role-management/content_creator'

    it 'calls the centralized role management enable endpoint with the content_creator factory role' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.centralized_role_management.enable_role_mapping('content_creator', 'rolemappa')
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'put'
    end
  end

  describe '#disable_role_mappings' do
    path = '/api/v1/centralized-role-management/content_creator'

    it 'calls the centralized role management disable endpoint with the content_creator factory role' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.centralized_role_management.disable_role_mapping('content_creator')
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'delete'
    end
  end
end
