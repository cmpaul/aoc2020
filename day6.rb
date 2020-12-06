# --- Day 6: Custom Customs ---

def sum_anyone(input)
  groups = []
  current_group = Set.new

  input.each_with_index do |line, index|
    current_group += line.split('')

    if line == '' || index == input.size - 1
      groups << current_group.size
      current_group = Set.new
    end
  end

  groups.inject(0) { |count, acc| count + acc }
end

# Part 1
input = [
  'abc',
  '',
  'a',
  'b',
  'c',
  '',
  'ab',
  'ac',
  '',
  'a',
  'a',
  'a',
  'a',
  '',
  'b'
]
# sum_anyone(input) # 11

# Part 2

def sum_everyone(input)
  groups = []
  current_group = nil

  input.each_with_index do |line, index|
    next if line == ''

    chars = line.split('')
    current_group = chars if current_group.nil?
    current_group = chars & current_group.to_a

    if input[index + 1] == '' || index == input.size - 1
      groups << current_group.size
      current_group = nil
    end
  end

  groups.inject(0) { |count, acc| count + acc }
end

input = File.readlines('day6-input.txt').map(&:strip)
sum_everyone(input)
