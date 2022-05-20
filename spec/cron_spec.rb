# frozen_string_literal: true

require 'spec_helper'

describe SFRest::Cron do
  before :each do
    @conn = SFRest.new "http://#{@mock_endpoint}", @mock_user, @mock_pass
  end

  describe '#get_cron_jobs' do
    path = '/api/v1/cronjobs'
    data = {
      'time' => '2021-11-25T13:18:44+00:00',
      'count' => 7,
      'cronjobs' => [
        {
          'nid' => 101,
          'name' => 'cron job 1',
          'stacks' => [1, 2],
          'sites_affected' => 'dev-sites',
          'interval' => '14 0,12 * * *',
          'drush_command' => 'cron',
          'thread_percentage' => 60
        },
        {
          'nid' => 102,
          'name' => 'cron job 2',
          'stacks' => [1, 2],
          'sites_affected' => 'all',
          'interval' => '0 0 1 1 *',
          'drush_command' => 'cron',
          'thread_percentage' => 40
        }
      ]
    }

    it 'gets a list of cron jobs' do
      stub_factory path, data.to_json
      expect(@conn.cron.get_cron_jobs).to eq data
    end

    it 'handles arguments correctly' do
      expect(@conn).to receive(:get).with('/api/v1/cronjobs?page=5&limit=6')
      @conn.cron.get_cron_jobs(5, 6)
    end
  end

  describe '#get_cron_job' do
    data = {
      'nid' => 101,
      'name' => 'cron job 1',
      'stacks' => [1, 2],
      'sites_affected' => 'dev-sites',
      'interval' => '14 0,12 * * *',
      'drush_command' => 'cron',
      'thread_percentage' => 60
    }

    it 'gets an individual cron job by its id' do
      id = 101
      stub_factory "/api/v1/cronjobs/#{id}", data.to_json
      expect(@conn.cron.get_cron_job(id)).to eq data
    end
  end

  describe '#create_cron_job' do
    path = '/api/v1/cronjobs'

    it 'creates a new cron job' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }

      job_name = 'test cron'
      job_command = 'cron'
      job_interval = '* * * * */3'
      job_scope = 'dev-sites'
      job_enabled = 1
      job_thread = 10
      job_stacks = [1]

      res = @conn.cron.create_cron_job(job_name,
                                       job_command,
                                       job_interval,
                                       job_scope,
                                       job_enabled,
                                       job_thread,
                                       job_stacks)
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'post'
      expect(JSON(res['body'])['name']).to eq job_name
      expect(JSON(res['body'])['command']).to eq job_command
      expect(JSON(res['body'])['interval']).to eq job_interval
      expect(JSON(res['body'])['sites_affected']).to eq job_scope
      expect(JSON(res['body'])['enabled']).to eq job_enabled
      expect(JSON(res['body'])['thread_percentage']).to eq job_thread
      expect(JSON(res['body'])['stacks']).to eq job_stacks
    end
  end

  describe '#edit_cron_job' do
    job_nid = 1234
    path = "/api/v1/cronjobs/#{job_nid}"

    it 'edits a cron job' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }

      job_name = 'test cron'
      job_command = 'cron'
      job_interval = '* * * * */3'
      job_scope = 'dev-sites'
      job_enabled = 1
      job_thread = 10
      job_stacks = [1]

      res = @conn.cron.edit_cron_job(job_nid,
                                     job_name,
                                     job_command,
                                     job_interval,
                                     job_scope,
                                     job_enabled,
                                     job_thread,
                                     job_stacks)
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'put'
      expect(JSON(res['body'])['name']).to eq job_name
      expect(JSON(res['body'])['command']).to eq job_command
      expect(JSON(res['body'])['interval']).to eq job_interval
      expect(JSON(res['body'])['sites_affected']).to eq job_scope
      expect(JSON(res['body'])['enabled']).to eq job_enabled
      expect(JSON(res['body'])['thread_percentage']).to eq job_thread
      expect(JSON(res['body'])['stacks']).to eq job_stacks
    end
  end

  describe '#delete_cron_job' do
    job_nid = 1234
    path = "/api/v1/cronjobs/#{job_nid}"

    it 'deletes a cron job' do
      stub_request(:any, /.*#{@mock_endpoint}.*#{path}/)
        .with(headers: @mock_headers)
        .to_return { |request| { body: { uri: request.uri, body: request.body, method: request.method }.to_json } }

      res = @conn.cron.delete_cron_job(job_nid)
      uri = URI res['uri']
      expect(uri.path).to eq path
      expect(res['method']).to eq 'delete'
    end
  end
end
