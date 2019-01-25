require_relative '../lib/website.rb'

RSpec.describe Website, "#fetch" do 
  context "when initialized without args" do 
    it "fetches the Hacker News HTML" do 
      website = Website.new
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
end
