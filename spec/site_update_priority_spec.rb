# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Site_update_priority do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#get_current_site_update_priority' do
    path = '/api/v1/site-update-priority'

    it 'calls the site update priority get endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.site_update_priority.current_update_priority
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end
  end

  describe '#set_site_update_priority' do
    path = '/api/v1/site-update-priority'

    it 'calls the site update priority put endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      payload = [22, 28, 24]
      res = @conn.site_update_priority.change_update_priority(payload)
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'put'
    end
  end

  describe '#reset_site_update_priority' do
    path = '/api/v1/site-update-priority'

    it 'calls the site update priority delete endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.site_update_priority.reset_update_priority
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'delete'
    end
  end
end
