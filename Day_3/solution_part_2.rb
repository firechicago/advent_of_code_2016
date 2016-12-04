class Triangle
  def initialize(sides)
    @side_1 = sides[0]
    @side_2 = sides[1]
    @side_3 = sides[2]
  end

  def possible?
    @side_1 + @side_2 > @side_3 &&
    @side_2 + @side_3 > @side_1 &&
    @side_1 + @side_3 > @side_2
  end
end

raw_data = File.readlines(ARGV[0])
three_rows = []
triangles = []
raw_data.each do |str|
  three_rows << str.scan(/\d+/).map(&:to_i)
  if three_rows.count == 3
    (0..2).each do |a|
      triangles << Triangle.new([
        three_rows[0][a],
        three_rows[1][a],
        three_rows[2][a]
      ])
    end
    three_rows = []
  end
end

puts triangles.select(&:possible?).count
