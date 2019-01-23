require_relative './NewsReader.rb'
require_relative './Options.rb'
require_relative './Website.rb'

opts = Options.new
site = Website.new('https://news.ycombinator.com')
reader = NewsReader.new(opts, site)
reader.read
