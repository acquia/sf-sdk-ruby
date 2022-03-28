# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Site_guard do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#get_current_site_guard_settings' do
    path = '/api/v1/site-guard'

    it 'calls the site guard get endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.site_guard.current_settings
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end
  end

  describe '#enable_site_guard' do
    path = '/api/v1/site-guard'

    it 'calls the site guard put endpoint with a message, username and password' do
      message = 'Please log in'
      username = 'john.doe'
      password = 'password1234'
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.site_guard.enable_site_guard(message, username, password)
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'put'
      expect(JSON(res['body'])['message']).to eq message
      expect(JSON(res['body'])['username']).to eq username
      expect(JSON(res['body'])['password']).to eq password
    end
  end

  describe '#disable_site_guard' do
    path = '/api/v1/site-guard'

    it 'calls the site guard delete endpoint and disables the site guard' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, method: request.method }.to_json } }
      res = @conn.site_guard.disable_site_guard
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'delete'
    end
  end
end
