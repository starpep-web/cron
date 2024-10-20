require_relative "../config/app"
require_relative "../services/redis/client"
require_relative "../utils/log"


class ExportsCleanupJob
  def initialize
    @logger = create_logger 'ExportsCleanupJob'
  end

  def register(scheduler)
    @logger.info "ExportsCleanupJob registered. Will run every hour."
    scheduler.cron "* * * * *", &method(:run)
  end

  def run
    artifact_task_ids = list_export_artifacts
    if artifact_task_ids.empty?
      @logger.info "No artifacts found in directory, nothing to remove."
      return
    end

    stored_task_ids = list_export_redis_tasks
    orphaned_task_ids = artifact_task_ids - stored_task_ids
    if orphaned_task_ids.empty?
      @logger.info "No orphaned artifacts found, nothing to remove."
      return
    end

    @logger.info "Found #{orphaned_task_ids.size} orphaned artifacts."
    remove_orphaned_artifacts(orphaned_task_ids)
  end

  private def list_export_artifacts
    artifact_files = Dir.glob File.join(CONFIG.temp_artifacts_location, "export-*.zip")
    artifact_files.map { |file| extract_task_id_from_filename file }
  end

  private def extract_task_id_from_filename(filename)
    pattern = /export-(?<uuid>.+)\.zip$/
    matched = filename.match(pattern)

    matched&.[](:uuid)
  end

  private def list_export_redis_tasks
    redis = RedisService.instance.client
    stored_task_keys = redis.scan_each(:match => "export:*").to_a
    stored_task_keys.map { |key| extract_task_id_from_redis_key key }
  end

  private def extract_task_id_from_redis_key(key)
    pattern = /export:(?<uuid>.+)$/
    matched = key.match(pattern)

    matched&.[](:uuid)
  end

  private def remove_orphaned_artifacts(task_ids)
    task_ids.each do |task_id|
      artifact_name = "export-#{task_id}.zip"
      artifact_filename = File.join(CONFIG.temp_artifacts_location, artifact_name)

      if File.exist? artifact_filename
        File.delete artifact_filename
        @logger.info "Deleted #{artifact_name}"
      end
    end
  end
end