require 'resque/errors'
require 'nokogiri'
require 'open-uri'

require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

# require 'watir-webdriver'

Capybara.default_driver = :poltergeist
Capybara.run_server = false

module RetriedJob
  include Capybara::DSL

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

    # url = "http://liveboard.cafef.vn/?center=1"
    # visit(url)
    # sleep(1)

    # doc = Nokogiri::HTML(page.html)
    # # rows = doc.at_xpath('//tbody')
    # doc.search('tbody > tr/td/label').each do |row|
    #   puts("asdsd #{row.text}")
    # end
  
  url = "http://stockboard.sbsc.com.vn/apps/StockBoard/SBSC/HOSE.html"
    visit(url)
    page.find_by_id('chkAAM')
    doc = Nokogiri::HTML(page.html)
    doc.css('#boardData').search('tr/th').each do |row|
      puts("asdsd #{row['title']} #{row.search('span').text}")
    end
  

    
  rescue Resque::TermException
    Resque.enqueue(self, key)
  end
end