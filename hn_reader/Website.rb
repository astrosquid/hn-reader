module HNReader
  class Website
    attr_accessor :url, :home, :page, :links

    @@sites = {
      1 => 'https://news.ycombinator.com',
      2 => 'https://belong.io',
      3 => 'https://pinboard.in/popular'
    }
    
    def initialize(website_id)
      @url = @@sites[website_id]
      @site_id = website_id
    end

    def get_news_site
      @home = RestClient.get(@url)
      @page = Nokogiri::HTML(@home)

      if @site_id == 1
        HackerNews.new
      elsif @site_id == 2
        BelongIO.new
      elsif @site_id == 3
        Pinboard.new
      end
    end
  end

  class HackerNews
    attr_reader :headline_data

    @@url = 'https://news.ycombinator.com'

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

  class BelongIO
    attr_reader :headline_data

    @@url = 'https://belong.io'

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

  class Pinboard
    attr_reader :headline_data

    @@url = 'https://pinboard.in/popular'

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
