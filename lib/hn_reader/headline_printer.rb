class HeadlinePrinter
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
