module HNReader
  class Application
    attr_reader :opts, :opts_with, :opts_without

    def initialize
      @opts_with = ['-l', '--link-only', '-h', '--hyperlink']
      @opts_without = ['-b', '--belong', '-p', '--pinboard']

      @opts = {
        :with => {},
        :without => []
      }
      self.parse_options
      puts "What the heck is going on"
    end

    def parse_options
      previous = nil

      ARGV.to_s.split(' ').each do |opt|
        if @opts_with.include? opt
          previous = opt
        end

        if previous
          #print @opts
          @opts[:with][previous] = opt
          previous = nil
        end

      end

      #print @opts
    end
  end
end
