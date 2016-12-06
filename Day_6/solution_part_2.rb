require 'pry'
raw_data = File.readlines(ARGV[0])

letter_frequencies = {}
(0..7).each do |index|
  letter_frequencies[index] = Hash.new(0)
end

raw_data.each do |message|
  message.chomp.split('').each_with_index do |letter, index|
    letter_frequencies[index][letter] += 1
  end
end

decrypted_message = letter_frequencies.map do |space|
  space[1].min_by { |a| a[1] }
end. map {|a| a[0]}.join

puts decrypted_message
