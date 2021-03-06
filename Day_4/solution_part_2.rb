require 'pry'
class Door
  attr_reader :room_number
  def initialize(encrypted_name: nil, room_number: nil, checksum: nil)
    @encrypted_name = encrypted_name
    @room_number = room_number
    @checksum = checksum
  end

  def correct_checksum
    letter_counts = Hash.new(0)
    @encrypted_name.each_char do |char|
      letter_counts[char] += 1
    end
    sorted = letter_counts.sort_by { |letter, count| [-count, letter] }
    sorted.map(&:first).reduce(&:+)[0..4]
  end

  def decyphered_name
    decyphered = ""
    @encrypted_name.each_char do |c|
      code = (c.ord - 97 + @room_number) % 26 + 97
      decyphered += code.chr
    end
    decyphered
  end

  def real?
    correct_checksum == @checksum
  end
end

raw_data = File.readlines(ARGV[0])

doors = raw_data.map do |str|
  matches = str.match(/([a-z-]+)(\d+)\[([a-z]+)\]/)
  Door.new({
    encrypted_name: matches[1].gsub(/-/, ""),
    room_number: matches[2].to_i,
    checksum: matches[3]
  })
end

doors.each do |door|
  if door.real? && door.decyphered_name == "northpoleobjectstorage"
    puts "#{door.decyphered_name}, #{door.room_number}"
  end
end

