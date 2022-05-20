# frozen_string_literal: true

module SFRest
  # Manipulates SF cron jobs.
  class Cron
    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Gets a list of cron jobs
    # @param [Integer] page
    # @param [Integer] items per page
    def get_cron_jobs(page = nil, limit = nil)
      args = {}
      args['page'] = page unless page.nil?
      args['limit'] = limit unless limit.nil?
      url = "/api/v1/cronjobs?#{args.map { |k, v| "#{k}=#{v}" }.join('&')}"
      @conn.get(url)
    end

    # Gets a cron job by its node id
    # @param [Integer] cron job nid
    def get_cron_job(nid)
      @conn.get("/api/v1/cronjobs/#{nid}")
    end

    # Creates a new cron job
    # @param [string] cron job name
    # @param [string] cron job command
    # @param [string] A unix cron expression
    # @param [string] Sites affected by cron
    # @param [int] if the cron should be enabled
    # @param [int] The percentage of cron threads that should be used for this cron
    # @param [array] An array of stack ids for which the cron should be enabled
    # rubocop: disable Metrics/ParameterLists
    def create_cron_job(name, command, interval, scope, enabled, thread_percentage, stacks)
      # rubocop: enable Metrics/ParameterLists
      payload = {
        'name' => name,
        'command' => command,
        'interval' => interval,
        'sites_affected' => scope,
        'enabled' => enabled,
        'thread_percentage' => thread_percentage,
        'stacks' => stacks
      }.to_json
      @conn.post('/api/v1/cronjobs', payload)
    end

    # Edits a cron job by its node id
    # @param [int] cron job nid
    # @param [string] cron job name
    # @param [string] cron job command
    # @param [string] A unix cron expression
    # @param [string] Sites affected by cron
    # @param [int] if the cron should be enabled
    # @param [int] The percentage of cron threads that should be used for this cron
    # @param [array] An array of stack ids for which the cron should be enabled
    # rubocop: disable Metrics/ParameterLists
    def edit_cron_job(nid, name, command, interval, scope, enabled, thread_percentage, stacks)
      # rubocop: enable Metrics/ParameterLists
      payload = {
        'name' => name,
        'command' => command,
        'interval' => interval,
        'sites_affected' => scope,
        'enabled' => enabled,
        'thread_percentage' => thread_percentage,
        'stacks' => stacks
      }.to_json
      @conn.put("/api/v1/cronjobs/#{nid}", payload)
    end

    # Deletes a cron job by its node id
    # @param [int] cron job nid
    def delete_cron_job(nid)
      @conn.delete("/api/v1/cronjobs/#{nid}")
    end
  end
end
