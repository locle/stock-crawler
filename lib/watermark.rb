require 'resque/errors'

module RetriedJob
  def on_failure_retry(e, *args)
    puts "Performing #{self} caused an exception (#{e}). Retrying..."
    Resque.enqueue self, *args
  end
end

class Watermark
  extend RetriedJob
  @queue = :watermark

	def initialize(key)  
    puts "Initialized Task worker instance #{key}"
  end


  def self.perform(key)
    puts "Performing #{key}"
  rescue Resque::TermException
    Resque.enqueue(self, key)
  end
end