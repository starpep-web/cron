require_relative '../config/app'


class ExportsCleanupJob
  def cron_expression
    '* * * * *'
  end

  def run
    puts CONFIG.redis_uri
  end
end