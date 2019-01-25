module HNReader
  class Website
    attr_accessor :url, :site_id

    @@sites = {
      1 => 'https://news.ycombinator.com',
      2 => 'https://belong.io',
      3 => 'https://pinboard.in/popular'
    }

    @@css_selectors = {
      1 => 'a.storylink',
      2 => 'div.item a',
      3 => 'a.bookmark_title'
    }
    
    def initialize(website_id)
      if @@sites.keys.include? website_id
        @url = @@sites[website_id]
        @site_id = website_id
      else 
        # raise error
      end
    end

    def get_news_site
      if @site_id == 1
        HackerNews.new
      elsif @site_id == 2
        BelongIO.new
      elsif @site_id == 3
        Pinboard.new
      end
    end
  end

  class HackerNews < Website
    attr_reader :headline_data

    @@url = 'https://news.ycombinator.com'

    def initialize
    end

    def get_data
      response = RestClient.get(@@url)
      html = Nokogiri::HTML(response)
      link_tags = html.css('a.storylink')

      headline_data = {} # int => [title, link]

      link_tags.each_with_index do |link_tag, i|
        index = i + 1
        headline_data[index] = [link_tag.content, link_tag['href']]
      end

      @headline_data = headline_data
    end
  end

  class BelongIO < Website
    attr_reader :headline_data

    @@url = 'https://belong.io'

    def initialize
    end

    def get_data
      response = RestClient.get(@@url)
      html = Nokogiri::HTML(response)
      link_tags = html.css('div.item > a')
      link_tags.pop

      headline_data = {} # int => [title, link]

      link_tags.each_with_index do |link_tag, i|
        index = i + 1
        headline_data[index] = [link_tag.content, link_tag['href']]
      end

      @headline_data = headline_data
    end

  end

  class Pinboard < Website
    attr_reader :headline_data

    @@url = 'https://pinboard.in/popular'

    def initialize
    end

    def get_data
      response = RestClient.get(@@url)
      html = Nokogiri::HTML(response)
      link_tags = html.css('a.bookmark_title')
      
      headline_data = {} # int => [title, link]

      link_tags.each_with_index do |link_tag, i|
        index = i + 1
        headline_data[index] = [link_tag.content, link_tag['href']]
      end

      @headline_data = headline_data
    end
  end
end
