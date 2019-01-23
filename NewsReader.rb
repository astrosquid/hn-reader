require 'nokogiri'
require 'rest-client'

class NewsReader
  def initialize(headline_data)
    @headline_data = headline_data
  end


  def print_headlines
    @headline_data.each do |key, headline|
      puts "#{key}: #{headline[0]}"
    end
  end
end
