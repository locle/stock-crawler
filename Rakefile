# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'bundler/setup'
Bundler.require(:default)

require './resque-example-app'
require 'resque/tasks'

task "resque:setup" do
  ENV['QUEUE'] = '*'
end