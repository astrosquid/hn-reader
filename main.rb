require_relative './hn_reader.rb'

opts = HNReader::Options.new
site = opts.analyze
news = site.get_news_site
read = HNReader::NewsReader.new(news.get_data)
read.print_headlines
