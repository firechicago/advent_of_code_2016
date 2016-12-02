class Keypad
  def initialize
    @row = 1
    @column = 1
  end

  def move(direction)
    case direction
    when "U"
      @row = bounds_check(@row - 1)
    when "D"
      @row = bounds_check(@row + 1)
    when "R"
      @column = bounds_check(@column + 1)
    when "L"
      @column = bounds_check(@column - 1)
    end
  end

  def value
    1 + @column + (@row * 3)
  end

  private def bounds_check(num)
    if num > 2
      2
    elsif num < 0
      0
    else
      num
    end
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
