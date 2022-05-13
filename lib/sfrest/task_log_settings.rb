# frozen_string_literal: true

module SFRest
  # We need to keep this naming due to the way connection.rb autoloads things.
  # rubocop: disable Naming/ClassAndModuleCamelCase
  # Manage the site default ownership feature.
  class Task_log_settings
    # rubocop: enable Naming/ClassAndModuleCamelCase

    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get current task log settings.
    #
    # @return [Array] an array containing current settings.
    def current_task_log_settings
      @conn.get('/api/v1/task-log-settings')
    end

    # Set the site ownership settings.
    # @param [String] The maximum log level that will be written to the log.
    # @param [String]  Level of Wip log messages to keep on successful completion.
    #
    # @return [Array] an array containing the message given by the server.
    def edit_task_log_settings(wip_log_maximum_level, wip_log_level)
      payload = {
        'wip_log_maximum_level' => wip_log_maximum_level,
        'wip_log_level' => wip_log_level
      }

      @conn.put('/api/v1/task-log-settings', payload.to_json)
    end

    # Reset current task log settings.
    #
    # @return [Array] an array containing the message given by the server.
    def reset_task_log_settings
      @conn.delete('/api/v1/task-log-settings')
    end
  end
end
