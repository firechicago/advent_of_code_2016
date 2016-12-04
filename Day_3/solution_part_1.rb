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
triangles = raw_data.map do |str|
  Triangle.new(str.scan(/\d+/).map(&:to_i))
end

puts triangles.select(&:possible?).count
