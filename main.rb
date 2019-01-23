require_relative './NewsReader.rb'

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
