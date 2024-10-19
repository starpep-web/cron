require 'rufus-scheduler'
require './module/jobs/test'

scheduler = Rufus::Scheduler.new

jobs = [
  TestJob.new
]

jobs.each do |job|
  scheduler.cron job.cron_expression, &job.method(:run)
end

scheduler.join
