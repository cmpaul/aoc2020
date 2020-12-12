# --- Day 12: Rain Risk ---

# Part 1
Ship = Struct.new(:facing, :x, :y)

def new_dir(facing, command)
  case facing
  when 'N'
    return 'W' if command == 'L'
    return 'E' if command == 'R'
  when 'S'
    return 'E' if command == 'L'
    return 'W' if command == 'R'
  when 'E'
    return 'N' if command == 'L'
    return 'S' if command == 'R'
  when 'W'
    return 'S' if command == 'L'
    return 'N' if command == 'R'
  else
    raise "Invalid command: #{c}"
  end
end

def turn(ship, command, value)
  new_facing = ship.facing
  (value / 90).times { new_facing = new_dir(new_facing, command) }
  ship.facing = new_facing
end

def move(ship, command, value)
  c = command == 'F' ? ship.facing : command
  case c
  when 'N'
    ship.y -= value
  when 'S'
    ship.y += value
  when 'E'
    ship.x += value
  when 'W'
    ship.x -= value
  else
    raise "Invalid command: #{c}"
  end
end

def dist(input)
  ship = Ship.new('E', 0, 0)
  input.each do |line|
    command = line[0]
    value = line[1..].to_i
    if %[L R].include?(command)
      turn(ship, command, value)
    else
      move(ship, command, value)
    end
  end
  ship.x.abs + ship.y.abs
end

input = %w[
  F10
  N3
  F7
  R90
  F11
]
dist(input)

input = File.readlines('day12-input.txt').map(&:strip)

# Part 2

Ship = Struct.new(:x, :y)
Waypoint = Struct.new(:x, :y)

def rotate(waypoint, command)
  raise "Invalid command #{command}" unless %[L R].include?(command)
  return Waypoint.new(-waypoint.y, waypoint.x) if command == 'L'
  Waypoint.new(waypoint.y, -waypoint.x)
end

def turn(waypoint, command, value)
  new_waypoint = waypoint
  (value / 90).times { new_waypoint = rotate(new_waypoint, command) }
  new_waypoint
end

def move_ship(ship, waypoint, value)
  Ship.new(ship.x + (waypoint.x * value), ship.y + (waypoint.y * value))
end

def move_waypoint(waypoint, command, value)
  new_waypoint = Waypoint.new(waypoint.x, waypoint.y)
  case command
  when 'N'
    new_waypoint.y += value
  when 'S'
    new_waypoint.y -= value
  when 'E'
    new_waypoint.x += value
  when 'W'
    new_waypoint.x -= value
  else
    raise "Invalid command: #{command}"
  end
  new_waypoint
end

def dist(input)
  ship = Ship.new(0, 0)
  waypoint = Waypoint.new(10, 1)

  input.each do |line|
    command = line[0]
    value = line[1..].to_i
    if %[L R].include?(command)
      waypoint = turn(waypoint, command, value)
    elsif command == 'F'
      ship = move_ship(ship, waypoint, value)
    else
      waypoint = move_waypoint(waypoint, command, value)
    end
  end
  ship.x.abs + ship.y.abs
end
