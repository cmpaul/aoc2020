# --- Day 11: Seating System ---

OCC = '#'
EMP = 'L'
FLR = '.'

# Part 1
def do_it(input)
  count = 0
  prev = []
  current = input
  while current.join('') != prev.join('') do
    count += 1
    prev = current.dup
    current = []
    for i in 0..(prev.size - 1) do
      row = prev[i]
      prev_row = i > 0 ? prev[i - 1] : nil
      next_row = i < prev.size - 1 ? prev[i + 1] : nil

      new_row = ''
      for j in 0..(row.size - 1) do
        is_floor = (row[j] == FLR)
        is_empty = (row[j] == EMP)
        is_occupied = (row[j] == OCC)
        num_occupied = 0

        # check right
        num_occupied += 1 if j < row.size - 1 && row[j + 1] == OCC
        # check left
        num_occupied += 1 if j > 0 && row[j - 1] == OCC

        if !next_row.nil?
          # check right-down
          num_occupied += 1 if j < row.size - 1 && next_row[j + 1] == OCC

          # check down
          num_occupied += 1 if next_row[j] == OCC

          # check left-down
          num_occupied += 1 if j > 0 && next_row[j - 1] == OCC
        end

        if !prev_row.nil?
          # check left-up
          num_occupied += 1 if j > 0 && prev_row[j - 1] == OCC

          # check up
          num_occupied += 1 if prev_row[j] == OCC

          # check right-up
          num_occupied += 1 if (j < row.size - 1) && prev_row[j + 1] == OCC
        end

        if is_empty && num_occupied == 0
          new_row += OCC
          next
        end

        if is_occupied && num_occupied >= 4
          new_row += EMP
          next
        end

        # No change
        new_row += row[j]
      end

      current << new_row
    end
  end
  current
end

def count_occupied(seatmap)
  seatmap.join('').count(OCC)
end

input = %w[
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
]
seatmap = do_it(input)
count_occupied(seatmap)

input = File.readlines('day11-input.txt').map(&:strip)

def right_empty?(seatmap, x, y)
  row = seatmap[y]
  i = x + 1
  while i < row.size
    return true if row[i] == EMP
    return false if row[i] == OCC
    i += 1
  end
  true
end

def left_empty?(seatmap, x, y)
  row = seatmap[y]
  i = x - 1
  while i >= 0
    return true if row[i] == EMP
    return false if row[i] == OCC
    i -= 1
  end
  true
end

def down_empty?(seatmap, x, y)
  j = y + 1
  while j < seatmap.size
    row = seatmap[j]
    return true if row[x] == EMP
    return false if row[x] == OCC
    j += 1
  end
  true
end

def up_empty?(seatmap, x, y)
  j = y - 1
  while j >= 0
    row = seatmap[j]
    return true if row[x] == EMP
    return false if row[x] == OCC
    j -= 1
  end
  true
end

def right_down_empty?(seatmap, x, y)
  i = x + 1
  j = y + 1
  while i < seatmap[0].size && j < seatmap.size
    return true if seatmap[j][i] == EMP
    return false if seatmap[j][i] == OCC
    i += 1
    j += 1
  end
  true
end

def right_up_empty?(seatmap, x, y)
  i = x + 1
  j = y - 1
  while i < seatmap[0].size && j >= 0
    row = seatmap[j]
    return true if row[i] == EMP
    return false if row[i] == OCC
    i += 1
    j -= 1
  end
  true
end

def left_down_empty?(seatmap, x, y)
  i = x - 1
  j = y + 1
  while i >= 0 && j < seatmap.size
    row = seatmap[j]
    return true if row[i] == EMP
    return false if row[i] == OCC
    i -= 1
    j += 1
  end
  true
end

def left_up_empty?(seatmap, x, y)
  i = x - 1
  j = y - 1
  while i >= 0 && j >= 0
    row = seatmap[j]
    return true if row[i] == EMP
    return false if row[i] == OCC
    i -= 1
    j -= 1
  end
  true
end

def occupy(seatmap)
  new_seatmap = []
  for y in 0..(seatmap.size - 1) do
    row = seatmap[y]
    new_row = ''
    for x in 0..(row.size - 1) do
      is_floor = (row[x] == FLR)
      is_empty = (row[x] == EMP)
      is_occupied = (row[x] == OCC)
      num_occupied = 0
      num_occupied += 1 unless right_empty?(seatmap, x, y)
      num_occupied += 1 unless right_down_empty?(seatmap, x, y)
      num_occupied += 1 unless down_empty?(seatmap, x, y)
      num_occupied += 1 unless left_down_empty?(seatmap, x, y)
      num_occupied += 1 unless left_empty?(seatmap, x, y)
      num_occupied += 1 unless left_up_empty?(seatmap, x, y)
      num_occupied += 1 unless up_empty?(seatmap, x, y)
      num_occupied += 1 unless right_up_empty?(seatmap, x, y)

      if is_empty && num_occupied == 0
        new_row += OCC
        next
      end

      if is_occupied && num_occupied >= 5
        new_row += EMP
        next
      end

      # No change
      new_row += row[x]
    end

    new_seatmap << new_row
  end
  new_seatmap
end

# Part 2
def seats(input)
  count = 0
  prev = []
  current = input
  while current.join('') != prev.join('') do
    count += 1
    prev = current.dup
    current = occupy(prev)
  end
  current
end

input = File.readlines('day11-input.txt').map(&:strip)
seatmap = seats(input)
count_occupied(seatmap)
