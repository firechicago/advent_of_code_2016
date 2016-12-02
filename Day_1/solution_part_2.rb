raw_data = File.read(ARGV[0])

moves = raw_data.split(', ').map do |raw_move|
  match = raw_move.match(/([LR])(\d+)/)
  { turn: match[1], distance: match[2].to_i }
end

class Walker
  attr_reader :location, :direction, :visited_locations
  def initialize
    @location = [0,0]
    @direction = [0,1]
    @visited_locations = []
  end

  def turn(left_or_right)
    case left_or_right
    when "L"
      @direction = [-1 * @direction[1], @direction[0]]
    when "R"
      @direction = [@direction[1], -1 * @direction[0]]
    else
      raise "Invalid Turn Direction, only 'R' and 'L' are valid"
    end
  end

  def travel(distance)
    distance.times do
      visited_locations << location.dup
      @location[0] += direction[0]
      @location[1] += direction[1]
      break if been_here?
    end
  end

  def total_distance
    location[0].abs + location[1].abs
  end

  def been_here?
    visited_locations.include?(location)
  end
end

walker = Walker.new
moves.each do |move|
  walker.turn(move[:turn])
  walker.travel(move[:distance])
  if walker.been_here?
    puts "[#{walker.location[0]}, #{walker.location[1]}]"
    puts walker.total_distance
    break
  end
end

