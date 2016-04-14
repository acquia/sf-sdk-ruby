module SFRest
  # Drive updates on the Site Factory
  class Update
    def initialize(conn)
      @conn = conn
    end

    # Gets the status information.
    def status_info
      current_path = '/api/v1/status'
      @conn.get(current_path)
    end

    # Modifies the status information.
    def modify_status(site_creation, site_duplication, domain_management, bulk_operations)
      current_path = '/api/v1/status'
      payload = { 'site_creation' => site_creation,
                  'site_duplication' => site_duplication,
                  'domain_management' => domain_management,
                  'bulk_operations' => bulk_operations }.to_json
      @conn.put(current_path, payload)
    end

    # Lists vcs refs.
    def list_vcs_refs(type = 'sites')
      current_path = '/api/v1/vcs?type=' << type
      @conn.get(current_path)
    end

    # Starts an update.
    def start_update(ref)
      update('sites', 'code, db', ref)
    end

    # Starts an update. The rest api supports the following
    # scope: sites|factory|both (defaults to 'sites')
    # start_time:
    # sites_type: code|code, db| code, db, registry (defaults to 'code, db')
    # factory_type: code|code, db (defaults to 'code, db')
    # sites_ref:
    # factory_ref:
    # This method does not filter or validate so that it can be used for
    # negative cases. (missing data)
    def update(scope = nil, sites_type = nil,
               sites_ref = nil, factory_type = nil,
               factory_ref = nil, start_time = nil)
      current_path = '/api/v1/update'
      update_data = {}
      update_data['scope'] = scope unless scope.nil?
      update_data['sites_type'] = sites_type unless sites_type.nil?
      update_data['sites_ref'] = sites_ref unless sites_ref.nil?
      update_data['factory_type'] = factory_type unless factory_type.nil?
      update_data['factory_ref'] = factory_ref unless factory_ref.nil?
      update_data['start_time'] = start_time unless start_time.nil?
      payload = update_data.to_json
      @conn.post(current_path, payload)
    end

    # Gets the list of updates.
    def update_list
      current_path = '/api/v1/update'
      @conn.get(current_path)
    end

    # Gets the progress of an update by id.
    def update_progress(update_id)
      current_path = '/api/v1/update/' + update_id.to_s + '/status'
      @conn.get(current_path)
    end

    # Pauses current update.
    def pause_update
      current_path = '/api/v1/update/pause'
      payload = { 'pause' => true }.to_json
      @conn.post(current_path, payload)
    end

    # Resumes current update.
    def resume_update
      current_path = '/api/v1/update/pause'
      payload = { 'pause' => false }.to_json
      @conn.post(current_path, payload)
    end
  end
end