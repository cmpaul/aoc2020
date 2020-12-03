# --- Day 3: Toboggan Trajectory ---
# https://adventofcode.com/2020/day/3

def trees_hit(map, right, down)
  x, y = right, down
  count = 0
  while y < map.size
    count += 1 if map[y][x % map[0].size] == '#'
    x += right
    y += down
  end
  count
end

# Sample:
#
# input = %w[
#   ..##.......
#   #...#...#..
#   .#....#..#.
#   ..#.#...#.#
#   .#...##..#.
#   ..#.##.....
#   .#.#.#....#
#   .#........#
#   #.##...#...
#   #...##....#
#   .#..#...#.#
# ]
# output = trees_hit(input, 3, 1) # 7

# Part 1:
# input = File.readlines('day3-input.txt').map(&:strip)
# output = trees_hit(input, 3, 1) # 240

# Part 2:
input = File.readlines('day3-input.txt').map(&:strip)
slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
slopes.map { |(r, d)| trees_hit(input, r, d) }.reduce(&:*)
