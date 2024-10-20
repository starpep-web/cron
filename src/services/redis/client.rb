require "redis"
require "singleton"
require_relative "../../config/app"

class RedisService
  include Singleton

  def initialize
    @redis = Redis.new(url: CONFIG.redis_uri)
  end

  def client
    @redis
  end
end