require "rufus-scheduler"
require_relative "./jobs/exports_cleanup"

scheduler = Rufus::Scheduler.new

jobs = [
  ExportsCleanupJob.new
]

jobs.each do |job|
  scheduler.cron job.cron_expression, &job.method(:run)
end

scheduler.join
