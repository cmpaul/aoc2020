# --- Day 1: Report Repair ---
# https://adventofcode.com/2020/day/1

def find_pair(entries, sum = 2020)
  diffs = []
  entries.each do |entry|
    diff = sum - entry
    return [entry, diff] if diffs.include?(diff)
    diffs << entry
  end
  nil
end

def find_triplet(entries, sum = 2020)
  entries.each do |entry|
    diff = sum - entry
    pair = find_pair(entries, diff)
    next if pair.nil?
    return [entry, pair[0], pair[1]]
  end
end

def report_repair(entries)
  # Part 1
  # pair = find_pair(entries)
  # pair[0] * pair[1]

  # Part 2
  triplet = find_triplet(entries)
  triplet[0] * triplet[1] * triplet[2]
end

# Part 1 sample
# input = [1721, 979, 366, 299, 675, 1456]
# output = 1721 * 299 = 514579

# Part 2 sample
# output = 979 * 366 * 675 = 241861950

input = File.readlines('day1-input.txt').map(&:strip).map(&:to_i)
output = report_repair(input)
