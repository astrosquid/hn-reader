require 'nokogiri'
require 'rest-client'

module HNReader
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
      @link_tags = @html.css(self.link_selector)
      if [2].include? @site_id
        @link_tags.pop
      end
      return @link_tags
    end

    def fetch
      response = RestClient.get(self.site_url)
      @html = Nokogiri::HTML(response)
    end

    def get_formatted_data
      formatted_data = {}
      @link_tags.each_with_index do |link_tag, i|
        href = link_tag['href']
        if @site_id == 1 && !href.include?('http')
          href = 'https://news.ycombinator.com/' + href
        end
        formatted_data[i + 1] = [link_tag.content, href]
      end
      @formatted_data = formatted_data
    end
  end
end
