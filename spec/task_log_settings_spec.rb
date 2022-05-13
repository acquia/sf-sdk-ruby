# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Task_log_settings do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#get_task_log_settings' do
    path = '/api/v1/task-log-settings'

    it 'calls the task log settings get endpoint' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.task_log_settings.current_task_log_settings
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'get'
    end
  end

  describe '#edit_task_log_settings' do
    path = '/api/v1/task-log-settings'

    it 'calls the task log settings put endpoint with parameter and edits task log settings' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }
      res = @conn.task_log_settings.edit_task_log_settings('trace', 'trace')
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'put'
      expect(JSON(res['body'])['wip_log_maximum_level']).to eq 'trace'
      expect(JSON(res['body'])['wip_log_level']).to eq 'trace'
    end
  end

  describe '#reset_task_log_settings' do
    path = '/api/v1/task-log-settings'

    it 'calls the task log settings delete endpoint and resets task log settings' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, method: request.method }.to_json } }
      res = @conn.task_log_settings.reset_task_log_settings
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'delete'
    end
  end
end
