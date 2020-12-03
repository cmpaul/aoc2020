# --- Day 2: Password Philosophy ---

# Part 1:
# LINE_REGEX = %r{(?<min>\d+)-(?<max>\d+) (?<letter>\w): (?<pwd>\w+)}
# def is_valid?(line)
#   matches = line.match(LINE_REGEX)
#   min = matches[:min].to_i
#   max = matches[:max].to_i
#   letter = matches[:letter]

#   count = 0
#   matches[:pwd].split('').each do |c|
#     count += 1 if c == letter
#     return false if count > max
#   end
#   count >= min
# end

def num_valid(input)
  input.count { |line| is_valid?(line) }
end

# Sample:
# input = [
#   '1-3 a: abcde',
#   '1-3 b: cdefg',
#   '2-9 c: ccccccccc',
# ]
# output = num_valid(input) # 2

# Part 1:
# input = File.readlines('day2-input.txt').map(&:strip)
# output = num_valid(input)

# Part 2:
LINE_REGEX = %r{(?<pos1>\d+)-(?<pos2>\d+) (?<letter>\w): (?<pwd>\w+)}
def is_valid?(line)
  matches = line.match(LINE_REGEX)
  pos1 = matches[:pos1].to_i - 1
  pos2 = matches[:pos2].to_i - 1
  letter = matches[:letter]
  pwd = matches[:pwd]

  (pwd[pos1] == letter && pwd[pos2] != letter) || (pwd[pos1] != letter && pwd[pos2] == letter)
end

input = File.readlines('day3-input.txt').map(&:strip)
num_valid(input)
