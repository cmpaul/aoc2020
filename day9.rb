# --- Day 9: Encoding Error ---

def is_sum?(value, numbers)
  numbers.each_with_index do |n, index|
    diff = value - n
    return true if numbers[index..].include?(diff)
  end
  false
end

def find_it(input, preamble_size = 25)
  cursor = preamble_size
  while (cursor < input.size) do
    value = input[cursor]
    return value unless is_sum?(value, input[(cursor - preamble_size)..(cursor - 1)])
    cursor += 1
  end
end

input = [
  35,
  20,
  15,
  25,
  47,
  40,
  62,
  55,
  65,
  95,
  102,
  117,
  150,
  182,
  127,
  219,
  299,
  277,
  309,
  576
]
find_it(input, 5) # 127

input = File.readlines('day9-input.txt').map(&:strip).map(&:to_i)
find_it(input) # 507622668

def group_sums(input, target)
  groups = []
  current_group = []
  current_sum = 0

  for i in 0..input.size
    cursor = i
    loop do
      break if cursor >= input.size

      current_sum += input[cursor]
      if current_sum < target
        current_group << input[cursor]
      elsif current_sum == target
        current_group << input[cursor]
        groups << current_group
        break
      else
        current_group = []
        current_sum = 0
        break
      end
      cursor += 1
    end
  end
  groups.reject { |g| g.size < 3 }
end
groups = group_sums(input, 507622668)
groups.first.min + groups.first.max
