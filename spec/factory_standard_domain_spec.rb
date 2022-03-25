# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Factory_standard_domain do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#get_current_factory_standard_domains' do
    path = '/api/v1/factory-standard-domains'

    it 'calls the factory standard domains endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.factory_standard_domain.factory_standard_domain_mapping
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end
  end

  describe '#enable_factory_standard_domains' do
    path = '/api/v1/factory-standard-domains/site_nonprod'

    it 'calls the factory standard domains enable endpoint with the site_nonprod template name' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      payload = ['template1-[sitename]-[environment].example.com']
      res = @conn.factory_standard_domain.enable_factory_standard_domain_template('site_nonprod', payload)
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'put'
    end
  end

  describe '#disable_factory_standard_domains' do
    path = '/api/v1/factory-standard-domains/site_nonprod'

    it 'calls the factory standard domains disable endpoint with the site_nonprod template name' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.factory_standard_domain.disable_factory_standard_domain_template('site_nonprod')
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'delete'
    end
  end

  describe '#backfill_factory_standard_domains' do
    path = '/api/v1/factory-standard-domains'

    it 'calls the factory standard domains backfill endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.factory_standard_domain.backfill_domains
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'post'
    end
  end
end
