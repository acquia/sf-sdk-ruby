# frozen_string_literal: true

module SFRest
  # Backup a site or restore onto that site
  class Backup
    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # cool stuff goes here
    # @param [Integer] site_id the node id of the site node
    # @return [Hash]
    def get_backups(site_id, datum = nil)
      current_path = "/api/v1/sites/#{site_id}/backups"
      pb = SFRest::Pathbuilder.new
      @conn.get URI.parse(pb.build_url_query(current_path, datum)).to_s
    end

    # Deletes a site backup.
    # @param [Integer] site_id Node id of site
    # @param [Integer] backup_id Id of backup to delete
    def delete_backup(site_id, backup_id)
      current_path = "/api/v1/sites/#{site_id}/backups/#{backup_id}"
      @conn.delete(current_path)
    end

    # Backs up a site.
    # @param [Integer] site_id
    # @param [Hash] datum Options to the backup
    # @option datum [String] 'label'
    # @option datum [Url] 'callback_url'
    # @option datum [String] 'callback_method' GET|POST
    # @option datum [Json] 'caller_data' json encoded string
    def create_backup(site_id, datum = nil)
      current_path = "/api/v1/sites/#{site_id}/backup"
      @conn.post(current_path, datum.to_json)
    end

    def backup_requests(rest_conn, site_nid, components)
        name = "rest#{Time.now.to_i}"
        payload = { 'label' => name, 'callback_url' => 'http://www.example.com', 'components' => components }.to_json
        output = rest_conn.post "/api/v1/sites/#{site_nid}/backup", payload
        task_id = output['task_id'].to_i
        expect(task_id).to be_positive
    end

    # Gets a url to download a backup
    # @param [Integer] site_id Node id of site
    # @param [Integer] backup_id Id of backup to delete
    # @param [Integer] lifetime TTL of the url
    def backup_url(site_id, backup_id, lifetime = 60)
      @conn.get("/api/v1/sites/#{site_id}/backups/#{backup_id}/url?lifetime=#{lifetime}")
    end

    # Configures the backup expiration and automatic deletion setting.
    # @param [Integer] days Number of days after which backups are deleted.
    def expiration_set(days)
      payload = {
        'expiration_days' => days
      }
      @conn.put('/api/v1/backup-expiration/', payload.to_json)
    end

    # Gets the current the backup expiration and automatic deletion setting.
    # @return [Hash]
    def expiration_get
      @conn.get('/api/v1/backup-expiration/')
    end
  end
end
