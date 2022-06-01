# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Security_settings do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#get_current_security_settings' do
    path = '/api/v1/security'

    it 'calls the current security settings get endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.security_settings.current_security_settings
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end

    it 'update security settings' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      datum = { minimum_password_length: 10, minimum_required_password_strength: 'weak' }
      res = @conn.security_settings.change_security_settings datum
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(JSON(res['body'])['minimum_password_length']).to eq 10
      expect(JSON(res['body'])['minimum_required_password_strength']).to eq 'weak'
      expect(res['method']).to eq 'put'
    end

    it 'Resets security settings' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.security_settings.reset_security_settings
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'delete'
    end
  end
end
