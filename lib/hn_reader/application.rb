require_relative './website'

module HNReader
  class Application
    attr_reader :opts, :opts_with, :opts_without

    def initialize
      @opts_with = ['-l', '--link-only', '-h']
      @opts_without = ['-b', '--belong', '-p', '--pinboard', '--hyperlink']

      @opts = {
        :with => {},
        :without => []
      }

      self.parse_options
      self.fetch_from_website
    end

    def fetch_from_website
      website = nil
      if @opts[:without].include? '--belong'
        website = HNReader::Website.new site_id: 2
      elsif @opts[:without].include? '--pinboard'
        website = HNReader::Website.new site_id: 3
      else
        website = HNReader::Website.new site_id: 1
      end

      website.fetch
      website.get_link_tags
      data = website.get_formatted_data
      HNReader::HeadlinePrinter.process_data_with_opts(data, @opts)
    end

    def parse_options
      previous = nil

      ARGV.each_with_index do |opt, index|
        if @opts_without.include? opt 
          @opts[:without] << opt
        end 

        if @opts_with.include? opt
          previous = opt
        end

        if previous
          @opts[:with][previous] = opt
          previous = nil
        end
      end
    end
  end
end

=begin
Generally we should avoid having to process flags with options. 
All flags should default to not having them, and instead we will 
see if the last opt is an integer. If it is, we'll only print
out that particular link combined with the other options.
=end
