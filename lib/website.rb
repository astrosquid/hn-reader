require 'nokogiri'
require 'rest-client'

class Website 
  attr_reader :html

  @@site_ids = {
    1 => 'https://news.ycombinator.com',
    2 => 'https://belong.io',
    3 => 'https://pinboard.in/popular'
  }

  @@link_selectors = {
    1 => 'a.storylink',
    2 => 'div.item > a',
    3 => 'a.bookmark_title'
  }

  def initialize(site_id: 1)
    @site_id = site_id
  end 

  def site_url
    @@site_ids[@site_id]
  end

  def link_selector
    @@link_selectors[@site_id]
  end

  def get_link_tags
    @links = @html.css(self.link_selector)
    if @site_id == 2
      @links.pop
    end
    return @links
  end

  def fetch
    response = RestClient.get(self.site_url)
    @html = Nokogiri::HTML(response)
  end
end
