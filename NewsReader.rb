require 'nokogiri'
require 'rest-client'

class NewsReader
  def initialize(opts, website)
    @opts = opts
    @website = website
  end

  def read
    headline_data = {} # int => [title, link]

    @website.get
    
    @website.links.each_with_index do |link_tag, i|
      index = i + 1
      headline_data[index] = [link_tag.content, link_tag['href']]
    end

    self.print_headlines headline_data
  end

  def print_headlines(headline_data)
    headline_data.each do |key, headline|
      puts "#{key}: #{headline[0]}"
    end
  end
end
