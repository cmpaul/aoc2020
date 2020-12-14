# --- Day 13: Shuttle Search ---

# Part 1
def find_bus(earliest_time, bus_ids)
  current_time = earliest_time
  while current_time > 0
    bus_ids.each do |bus_id|
      return [current_time, bus_id] if current_time % bus_id == 0
    end
    current_time += 1
  end
end

def doit(earliest_time, buses_running)
  bus_ids = buses_running.split(',').reject { |b| b == 'x' }.map(&:to_i)
  (bus_time, bus_id) = find_bus(earliest_time, bus_ids)
  bus_id * (bus_time - earliest_time)
end

input = [
  '939',
  '7,13,x,x,59,x,31,19'
]
doit(input[0].to_i, input[1])

input = File.readlines('day13-input.txt').map(&:strip)

# Part 2
def is_seq?(bus_ids, timestamp)
  bus_ids.each_with_index do |bus_id, index|
    next if bus_id == 0
    return false if ((timestamp % bus_id) + index) != 0
  end
  true
end

def brute(buses_running)
  bus_ids = buses_running.split(',').map(&:to_i)
  timestep = bus_ids.reject(&:zero?).min
  timestamp = 0
  loop do
    return timestamp if is_seq?(bus_ids, timestamp)
    timestamp += timestep
  end
end
brute(input[1]) # THIS WILL NEVER COMPLETE

# Likely need to implement Chinese Remainder Theorem:
# http://www-math.ucdenver.edu/~wcherowi/courses/m5410/crt.pdf
