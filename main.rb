require 'nokogiri'
require 'rest-client'

url = 'https://news.ycombinator.com'
home = RestClient.get(url)
page = Nokogiri::HTML(home)
links = page.css('a.storylink')

titles = links.map do |link|
  if link.content.length > 49
    link.content[0, 46] + '...'
  else 
    link.content
  end
end

titles.each_with_index do |title, i|
  if i < 9
    puts " #{i + 1}: #{title}"
  else
    puts "#{i + 1}: #{title}"
  end
end
