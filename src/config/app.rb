require "dotenv"
Dotenv.load

class Config
  attr_accessor :redis_uri, :temp_artifacts_location

  def initialize
    @redis_uri = ENV["REDIS_URI"]
    @temp_artifacts_location = ENV["TEMP_ARTIFACTS_LOCATION"]
  end
end

CONFIG = Config.new
