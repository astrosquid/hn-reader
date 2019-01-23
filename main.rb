require_relative './NewsReader.rb'
require_relative './Options.rb'
require_relative './Website.rb'

opts = Options.new
site = opts.analyze # either prints help or returns website
news = site.get_news_site
news.get_data

reader = NewsReader.new(news.headline_data)
reader.print_headlines
