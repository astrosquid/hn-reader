module HNReader
  class HeadlinePrinter
    def self.process_data_with_opts(headline_data, opts)
      if opts[:without].include? '--hyperlink'
        self.numbered_hyperlinks(headline_data)
      else
        self.numbered_headlines(headline_data)
      end
    end

    def self.numbered_hyperlinks(headline_data)
      headline_data.each do |key, data|
        if key < 10
          print "  #{key}: "
        elsif key > 9 && key < 100
          print " #{key}: "
        elsif key > 99
          print "#{key}: "
        end
        TerminalLink::Link.new(data[1], data[0]).print
      end
    end

    def self.numbered_headlines(headline_data)
      headline_data.each do |key, data|
        if key < 10 
          puts "  #{key}: #{data[0]}"
        elsif key > 9 && key < 100
          puts " #{key}: #{data[0]}"
        elsif key > 99
          puts "#{key}: #{data[0]}"
        end
      end
    end
  end
end
