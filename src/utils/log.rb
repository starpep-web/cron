require "logger"

def create_logger(name)
  logger = Logger.new STDOUT
  logger.formatter = proc do |severity, datetime, progname, msg|
    formatted_date = datetime.strftime("%Y-%m-%d %I:%M:%S %p")
    "(#{formatted_date} @ #{name}) - [#{severity}] - #{msg}\n"
  end

  logger
end