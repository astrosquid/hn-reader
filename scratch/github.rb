require 'nokogiri'
require 'rest-client'

response = RestClient.get('https://github.com/trending')
html = Nokogiri::HTML(response) 

links = html.css('h3 > a')
descs = html.css('.py-1 > p')
links.each_with_index do |link, index|
  title = link['href'].split('')
  title.shift
  title = title.join('')
  print title + ': '
  puts descs[index].content.strip
end
