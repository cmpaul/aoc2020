# --- Day 5: Binary Boarding ---

def row(ticket)
  rows = (0..127).to_a
  for i in 0..6
    partition = rows.each_slice(rows.size / 2).to_a
    if ticket[i] == 'F'
      rows = partition[0]
    else
      rows = partition[1]
    end
  end
  rows.first
end

def seat(ticket)
  seats = (0..7).to_a
  for i in 7..9
    partition = seats.each_slice(seats.size / 2).to_a
    if ticket[i] == 'L'
      seats = partition[0]
    else
      seats = partition[1]
    end
  end
  seats.first
end

def seat_id(ticket)
  row(ticket) * 8 + seat(ticket)
end

# Part 1
# seat_id('FBFBBFFRLR') # 357
# input = File.readlines('day5-input.txt').map(&:strip)
# input.map { |ticket| seat_id(ticket) }.max

# Part 2
input = File.readlines('day5-input.txt').map(&:strip)
available_seats = (0..1023).to_a
taken_seats = input.map { |ticket| seat_id(ticket) }
available_seats - taken_seats
