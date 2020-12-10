# --- Day 10: Adapter Array ---

def diffs(input)
  adapters = input.sort
  diffs = [0, 0, 0]
  for i in 0..(adapters.size - 1) do
    curr = adapters[i]
    prev = (i == 0) ? 0 : adapters[i - 1]
    diffs[(curr - prev) - 1] += 1
  end
  diffs[2] += 1 # Last one is always 3 higher
  diffs
end

# input = [
#   16,
#   10,
#   15,
#   5,
#   1,
#   11,
#   7,
#   19,
#   6,
#   12,
#   4
# ]

# input = [
#   28,
#   33,
#   18,
#   42,
#   31,
#   14,
#   46,
#   20,
#   48,
#   47,
#   24,
#   23,
#   49,
#   45,
#   19,
#   38,
#   39,
#   11,
#   1,
#   32,
#   25,
#   35,
#   8,
#   17,
#   7,
#   9,
#   4,
#   2,
#   34,
#   10,
#   3
# ]

input = File.readlines('day10-input.txt').map(&:strip).map(&:to_i)
diffs(input)

# Part 2
@memo = {}
def count_perms(adapters, start, finish)
  key = "#{start}:#{adapters.size}"
  return @memo[key] if @memo.key?(key)

  perms = 0
  perms += 1 if (finish - start <= 3)
  return perms if adapters.empty?

  perms += count_perms(adapters[1..], adapters[0], finish) if adapters[0] - start <= 3
  perms += count_perms(adapters[1..], start, finish)

  @memo[key] = perms
end

def permutations(input)
  adapters = input.sort
  count_perms(adapters, 0, adapters.max + 3)
end

permutations(input)
