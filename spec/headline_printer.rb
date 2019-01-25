require_relative '../lib/headline_printer.rb'

RSpec.describe HeadlinePrinter, "#self.numbered_headlines" do
  context "when given headline data in the format 1 => [title, url]" do
    it "should print headlines in the format '1: Example'" do
      data = { 1 => ['Example', 'http://example.com'] }
      expect{ HeadlinePrinter.numbered_headlines(data) }.to output("  1: Example\n").to_stdout
    end

    it "should print numbers with correct spacing" do 
      data = {
        1 => ['Example', 'http://example.com'],
        10 => ['Example', 'http://example.com'],
        100 => ['Example', 'http://example.com']
      }
      expected = "  1: Example\n 10: Example\n100: Example\n"
      expect{ HeadlinePrinter.numbered_headlines(data) }.to output(expected).to_stdout
    end
  end
end
