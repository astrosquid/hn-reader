require 'nokogiri'
require 'rest-client'

class Website 
  attr_reader :html

  @@site_ids = {
    1 => 'https://news.ycombinator.com',
    2 => 'https://belong.io'
  }

  def initialize(site_id: 1)
    @site_id = site_id
  end 

  def site_url
    @@site_ids[@site_id]
  end

  def fetch
    response = RestClient.get(self.site_url)
    @html = Nokogiri::HTML(response)
  end
end
