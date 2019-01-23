require_relative './Website.rb'

class Options
  attr_reader :opts

  @@help = %{
NAME
  hn-reader - read headlines from aggregator sites

SYNOPSIS
  hn-reader 
  hn-reader -h
  hn-reader --help
  }

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

    if @opts[:empty].include? "belong"
      # make a belong request instead
      return Website.new(2)
    end

    Website.new(1)
  end
end
