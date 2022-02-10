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
  end
end
