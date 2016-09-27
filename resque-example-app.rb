require 'bundler/setup'
Bundler.require(:default)
require File.expand_path('../lib/watermark', __FILE__)
require 'sinatra/redis'

configure do
  redis_url = ENV["REDISCLOUD_URL"] || ENV["OPENREDIS_URL"] || ENV["REDISGREEN_URL"] || ENV["REDISTOGO_URL"]
  # redis_url = "redis://localhost:6379/"
  uri = URI.parse(redis_url)
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  Resque.redis.namespace = "resque:stock-crawler"
  set :redis, redis_url
end

get "/" do
  @working = Resque.working
  erb :index
end

get '/task' do
  Resque.enqueue(Watermark, "12")
end