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

