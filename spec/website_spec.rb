require 'hn_reader'

RSpec.describe HNReader::Website, "#fetch" do 
  context "when initialized without args" do 
    it "fetches the Hacker News HTML" do 
      website =HNReader::Website.new
      website.fetch
      expect(website.html.to_s.include? "<title>Hacker News</title>").to eq true
    end
  end

  context "when initialized with 1" do 
    it "fetches the Hacker News HTML" do 
      website =HNReader::Website.new(site_id: 1)
      website.fetch
      expect(website.html.to_s.include? "<title>Hacker News</title>").to eq true
    end
  end

  context "when initialized with 2" do
    it "fetches the BelongIO HTML" do 
      website =HNReader::Website.new(site_id: 2)
      website.fetch
      expect(website.html.to_s.include? "<title>BELONG</title>").to eq true
    end
  end

  context "when initialized with 3" do 
    it "fetches the HTML from Pinboard's /popular page" do 
      website =HNReader::Website.new(site_id: 3)
      website.fetch
      expect(website.html.to_s.include? "<title>Pinboard: popular bookmarks</title>").to eq true
    end
  end

  context "when initialized with 4" do 
    it "fetches the HTML from GitHub's /trending page" do 
      website =HNReader::Website.new(site_id: 4)
      website.fetch
      expect(website.html.to_s.include? "<title>Trending  repositories on GitHub today · GitHub</title>").to eq true
    end
  end
end

RSpec.describe HNReader::Website, "#get_link_tags" do 
  context "when initialized without args" do
    it "uses the Hacker News selectors to find links" do 
      hn =HNReader::Website.new
      hn.fetch
      links = hn.get_link_tags
      expect(links.length).to eq 30
    end
  end

  context "when initialized with 1" do
    it "uses the Hacker News selectors to find links" do 
      hn =HNReader::Website.new(site_id: 1)
      hn.fetch
      links = hn.get_link_tags
      expect(links.length).to eq 30
    end
  end

  context "when initialized with 2" do
    it "uses the BelongIO css selectors to find links" do 
      belong =HNReader::Website.new(site_id: 2)
      belong.fetch
      links = belong.get_link_tags
      expect(links.length > 0).to eq true
    end
  end

  context "when initialized with 3" do 
    it "uses the Pinboard css selectors to find links from popular bookmarks" do
      pinboard =HNReader::Website.new(site_id: 3)
      pinboard.fetch
      links = pinboard.get_link_tags
      expect(links.length).to eq 100
    end
  end

  context "when initialized with 4" do 
    it "uses the GitHub css selectors to find links from popular bookmarks" do
      pinboard =HNReader::Website.new(site_id: 4)
      pinboard.fetch
      links = pinboard.get_link_tags
      expect(links.length).to eq 25
    end
  end
end

RSpec.describe HNReader::Website, "#collect_formatted_data" do 
  context "when initialized without args (Hacker News)" do 
    it "formats Hacker News links into a hash where keys point to an array, e.g. 1 => [title, link]" do
      website =HNReader::Website.new()
      website.fetch
      website.get_link_tags
      data = website.get_formatted_data
      expect(data[1]).to_not eq nil
      expect(data[30]).to_not eq nil
      data.each do |key, array|
        expect(key.class).to eq Integer
        expect(array.class).to eq Array
        expect(array[0].class).to eq String
        expect(array[1].class).to eq String
        link = array[1] 
        expect(link.to_s.include? "http").to eq true
      end
    end
  end

  context "when initialized with 1 (Hacker News)" do 
    it "formats Hacker News links into a hash where keys point to an array, e.g. 1 => [title, link]" do
      website =HNReader::Website.new(site_id: 1)
      website.fetch
      website.get_link_tags
      data = website.get_formatted_data
      expect(data[1]).to_not eq nil
      expect(data[30]).to_not eq nil
      data.each do |key, array|
        expect(key.class).to eq Integer
        expect(array.class).to eq Array
        expect(array[0].class).to eq String
        expect(array[1].class).to eq String
        link = array[1] 
        expect(link.to_s.include? "http").to eq true
      end
    end
  end

  context "when initialized with 2 (BelongIO)" do 
    it "formats BelongIO data into a hash where keys point to an array, e.g. 1 => [title, link]" do
      website =HNReader::Website.new(site_id: 2)
      website.fetch
      website.get_link_tags
      data = website.get_formatted_data
      expect(data[1]).to_not eq nil
      expect(data.keys.last).to_not eq nil
      data.each do |key, array|
        expect(key.class).to eq Integer
        expect(array.class).to eq Array
        expect(array[0].class).to eq String
        expect(array[1].class).to eq String
        link = array[1] 
        expect(link.to_s.include? "http").to eq true
      end
    end
  end

  context "when initialized with 3 (Pinboard)" do 
    it "formats Pinboard data into a hash where keys point to an array, e.g. 1 => [title, link]" do
      website =HNReader::Website.new(site_id: 3)
      website.fetch
      website.get_link_tags
      data = website.get_formatted_data
      expect(data[1]).to_not eq nil
      expect(data[30]).to_not eq nil
      data.each do |key, array|
        expect(key.class).to eq Integer
        expect(array.class).to eq Array
        expect(array[0].class).to eq String
        expect(array[1].class).to eq String
        link = array[1] 
        expect(link.to_s.include? "http").to eq true
      end
    end
  end

  context "when initialized with 4 (GitHub)" do 
    it "formats GitHub data into a hash where keys point to an array, e.g. 1 => [title, link]" do
      website =HNReader::Website.new(site_id: 4)
      website.fetch
      website.get_link_tags
      data = website.get_formatted_data
      expect(data[1]).to_not eq nil
      expect(data[25]).to_not eq nil
      data.each do |key, array|
        expect(key.class).to eq Integer
        expect(array.class).to eq Array
        expect(array[0].class).to eq String
        expect(array[1].class).to eq String
        link = array[1] 
        expect(link.to_s.include? "http").to eq true
      end
    end
  end
end

