require './resque-example-app.rb'
require 'resque/server'

run Rack::URLMap.new \
  "/"       => Sinatra::Application,
  "/resque" => Resque::Server.new

#require ::File.expand_path('../config/environment', __FILE__)
#run Rails.application