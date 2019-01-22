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

class Options
  attr_reader :opts

  def initialize
    args = Hash[ ARGV.flat_map{|s| s.scan(/--?([^=\s]+)(?:=(\S+))?/) } ]
    opts = {:empty => []}
    args.keys.each do |arg|
      if !!args[arg]
        opts[arg] = args[arg]
      else
        opts[:empty] << arg
      end
    end
    @opts = opts
  end
end

class Website
  attr_accessor :url, :home, :page, :links
  
  def initialize(url)
    @url = url
  end

  def get
    @home = RestClient.get(@url)
    @page = Nokogiri::HTML(@home)
    @links = @page.css('a.storylink')
  end
end

opts = Options.new
site = Website.new('https://news.ycombinator.com')
reader = NewsReader.new(opts, site)
reader.read
