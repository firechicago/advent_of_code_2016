class Keypad
  PAD = [
    [nil,nil,1,nil,nil],
    [nil,2,3,4,nil],
    [5,6,7,8,9],
    [nil,"A","B","C",nil],
    [nil,nil,"D",nil,nil]
  ].freeze

  def initialize
    @row = 2
    @column = 2
  end

  def move(direction)
    case direction
    when "U"
      @row = @row - 1 if bounds_check(@row - 1, @column)
    when "D"
      @row = @row + 1 if bounds_check(@row + 1, @column)
    when "R"
      @column = @column + 1 if bounds_check(@row, @column + 1)
    when "L"
      @column = @column - 1 if bounds_check(@row, @column - 1)
    end
  end

  def value
    PAD.dig(@row, @column)
  end

  private def bounds_check(row, column)
    row >= 0 && column >= 0 && PAD.dig(row, column)
  end
end

raw_data = File.readlines(ARGV[0])
code = raw_data.map do |line|
  keypad = Keypad.new
  line.each_char do |direction|
    keypad.move(direction)
  end
  keypad.value.to_s
end

puts code.reduce(&:+)
