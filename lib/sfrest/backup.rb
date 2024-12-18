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

    def execute_backup(options = {})
      api = options[:api]
      rconn = options[:rconn]
      acsf = options[:acsf]
      site_nid = options[:site_nid]
      name = options[:name]
      components = options[:components]
      user = options[:user]

      case api
      when 'rest'
        execute_rest_backup(rconn, site_nid, name, components)
      when 'drush'
        execute_drush_backup(acsf, site_nid, name, components, user)
      else
        raise "Unsupported API: #{api}"
      end
    end

    def execute_rest_backup(rconn, site_nid, name, components)
      payload = {
        'label' => name,
        'components' => components
      }.to_json
      rconn.post "/api/v1/sites/#{site_nid}/backup", payload
    end

    def execute_drush_backup(acsf, site_nid, name, components, user)
      drush_components = components.is_a?(Array) ? components.join(',') : components
      drush_cmd = "sf-backup #{site_nid} \"#{name}\" --components=\"#{drush_components}\" --user=#{user} --format=json"
      drush_cmd_update = acsf.drush drush_cmd
      result = acsf.factory_ssh.exec!(drush_cmd_update).strip
      JSON.parse(result)
    end

    def parse_response(response)
      raise "Unexpected response type: #{response.class}" unless response.is_a?(Hash)

      [response['task_id'], response['message']]
    end

    def parse_components(components_json)
      JSON.parse(components_json)
    rescue JSON::ParserError
      components_json # Keep the original string if it's not valid JSON
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
