# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Site_ownership do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#get_current_role_mappings' do
    path = '/api/v1/site-ownership'

    it 'calls the site ownership get endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.site_ownership.default_ownership
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end
  end

  describe '#set_role_mappings' do
    path = '/api/v1/site-ownership'

    it 'calls the site ownership put endpoint with a username' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.site_ownership.make_default_owner('john.doe')
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'put'
      expect(JSON(res['body'])['username']).to eq 'john.doe'
    end
  end

  describe '#remove_role_mappings' do
    path = '/api/v1/site-ownership'

    it 'calls the site ownership delete endpoint and removes the owner' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, method: request.method }.to_json } }
      res = @conn.site_ownership.remove_default_owner
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'delete'
    end
  end

  describe '#transfer_site_ownership' do
    id = 123
    path = '/api/v1/site-ownership/#{id}'

    it 'calls the site ownership post endpoint and transfers site owner' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, method: request.method }.to_json } }
      res = @conn.site_ownership.transfer_site_ownership('john.dee')
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'post'
      expect(JSON(res['body'])['username']).to eq 'john.doe'
    end
  end
end
