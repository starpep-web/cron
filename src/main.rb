require "rufus-scheduler"
require_relative "./jobs/exports_cleanup"

scheduler = Rufus::Scheduler.new

jobs = [
  ExportsCleanupJob.new
]

jobs.each do |job|
  job.register scheduler
end

scheduler.join
