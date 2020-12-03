# --- Day 1: Report Repair ---
# https://adventofcode.com/2020/day/1

def find_pair(entries)
  diffs = []
  entries.each do |entry|
    diff = 2020 - entry
    return [entry, diff] if diffs.include?(diff)
    diffs << entry
  end
end

def find_triplet(entries)
  # TODO
end

def report_repair(entries)
  # Part 1
  # pair = find_pair(entries)
  # pair[0] * pair[1]

  # Part 2
  triplet = find_triplet(entries)
  triplet[0] * triplet[1] * triplet[2]
end

# input = [1721, 979, 366, 299, 675, 1456]
# output = 1721 * 299 = 514579

input = File.readlines('day1-input.txt').map(&:strip).map(&:to_i)
output = report_repair(input)
