class Options
  attr_reader :opts

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
end
