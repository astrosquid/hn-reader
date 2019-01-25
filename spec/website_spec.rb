require_relative '../lib/website.rb'

RSpec.describe Website, "#fetch" do 
  context "when initialized without args" do 
    it "fetches the Hacker News HTML" do 
      website = Website.new
      website.fetch
      expect(website.html.to_s.include? "<title>Hacker News</title>").to eq true
    end
  end

  context "when initialized with 1" do 
    it "fetches the Hacker News HTML" do 
      website = Website.new(site_id: 1)
      website.fetch
      expect(website.html.to_s.include? "<title>Hacker News</title>").to eq true
    end
  end

  context "when initialized with 2" do
    it "fetches the BelongIO HTML" do 
      website = Website.new(site_id: 2)
      website.fetch
      expect(website.html.to_s.include? "<title>BELONG</title>").to eq true
    end
  end

  context "when initialized with 3" do 
    it "fetches the HTML from Pinboard's /popular page" do 
      website = Website.new(site_id: 3)
      website.fetch
      expect(website.html.to_s.include? "<title>Pinboard: popular bookmarks</title>").to eq true
    end
  end
end

RSpec.describe Website, "#get_link_tags" do 
  context "when initialized without args" do
    it "uses the Hacker News selectors to find links" do 
      hn = Website.new
      hn.fetch
      links = hn.get_link_tags
      expect(links.length).to eq 30
    end
  end

  context "when initialized with 1" do
    it "uses the Hacker News selectors to find links" do 
      hn = Website.new(site_id: 1)
      hn.fetch
      links = hn.get_link_tags
      expect(links.length).to eq 30
    end
  end

  context "when initialized with 2" do
    it "uses the BelongIO css selectors to find links" do 
      belong = Website.new(site_id: 2)
      belong.fetch
      links = belong.get_link_tags
      expect(links.length).to eq 38
    end
  end

  context "when initialized with 3" do 
    it "uses the Pinboard css selectors to find links from popular bookmarks" do
      pinboard = Website.new(site_id: 3)
      pinboard.fetch
      links = pinboard.get_link_tags
      expect(links.length).to eq 100
    end
  end
end
