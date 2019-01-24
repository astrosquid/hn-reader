require_relative './Website.rb'

class Options
  attr_reader :opts

  @@help = %{
NAME
  hn-reader - read headlines from aggregator sites

SYNOPSIS
  hn-reader: Hacker News headlines
    Hacker News headlines

  hn-reader [-h || --help]: print this help

  hn-reader [-v || --version]: print version

  hn-reader --belong
    Belong headlines

  hn-reader --pinboard
    Pinboard headlines
  }

  @@version = 'hn-reader v0.9'

  def initialize
    args = Hash[ ARGV.flat_map{|s| s.scan(/--?([^=\s]+)(?:=(\S+))?/) } ]
    opts = {:empty => []}
    args.keys.each do |arg|
      if !!args[arg]
        opts[arg] = args[arg]
      else
        opts[:empty] << arg
      end
    end
    @opts = opts
  end

  def analyze
    if @opts[:empty].include?('help') || @opts[:empty].include?('h')
      puts @@help
      exit(0)
    end
    
    if @opts[:empty].include?('version') || @opts[:empty].include?('v')
      puts @@version
      exit(0)
    end

    if @opts[:empty].include? "belong"
      return Website.new(2)
    end

    if @opts[:empty].include? "pinboard"
      return Website.new(3)
    end

    Website.new(1)
  end
end
