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
end
