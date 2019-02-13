require 'nokogiri'
require 'rest-client'

module HNReader
  class Website 
    attr_reader :html

    @@site_ids = {
      1 => 'https://news.ycombinator.com',
      2 => 'https://belong.io',
      3 => 'https://pinboard.in/popular',
      4 => 'https://github.com/trending'
    }

    @@link_selectors = {
      1 => 'a.storylink',
      2 => 'div.item > a',
      3 => 'a.bookmark_title',
      4 => 'h3 > a'
    }

    @@desc_selectors = {
      4 => '.py-1 > p'
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
      response = RestClient.get self.site_url
      @html = Nokogiri::HTML response
    end

    def get_descs
      descs = @html.css(@@desc_selectors[@site_id])
      descs.map do |desc|
        desc.content.strip
      end
    end

    def add_desc_to_titles(data)
      if @site_id == 4
        descs = self.get_descs

        descs.each_with_index do |desc, index|
          data[index + 1][0] += ", #{desc}"
        end
      end
      data
    end

    def get_formatted_data
      formatted_data = {}
      @link_tags.each_with_index do |link_tag, i|
        href = link_tag['href'].strip

        if @site_id == 1 && !href.include?('http')
          href = 'https://news.ycombinator.com/' + href
        end

        if @site_id == 4
          href = 'https://github.com' + href
        end

        formatted_data[i + 1] = [link_tag.content.strip, href]
      end

      @formatted_data = formatted_data
      @formatted_data = self.add_desc_to_titles @formatted_data
    end
  end
end
