# --- Day 7: Handy Haversacks ---
RULE_REGEX = /\A(?<color>.+) bags contain (?<bags>.*).\z/
CONTAINS_REGEX = /\A(?<num>\d+) (?<color>.+)\z/

def parse(input)
  input.each_with_object({}) do |line, acc|
    rule = line.match(RULE_REGEX)
    color = rule[:color]
    acc[color] = {}
    next if rule[:bags] == 'no other bags'

    bags = rule[:bags].gsub(/bag[s]*/, '').split(',').map(&:strip)
    bags.each do |bag|
      matches = bag.match(CONTAINS_REGEX)
      acc[color][matches[:color]] = matches[:num].to_i
    end
  end
end

def parents(target, rules)
  bags = Set.new
  rules.each do |k, v|
    next unless v.keys.include?(target)
    bags << k
    bags += parents(k, rules)
  end
  bags
end

def count_parents(target, rules)
  parents(target, rules).size
end

# part 1
# input = [
#   'light red bags contain 1 bright white bag, 2 muted yellow bags.',
#   'dark orange bags contain 3 bright white bags, 4 muted yellow bags.',
#   'bright white bags contain 1 shiny gold bag.',
#   'muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.',
#   'shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.',
#   'dark olive bags contain 3 faded blue bags, 4 dotted black bags.',
#   'vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.',
#   'faded blue bags contain no other bags.',
#   'dotted black bags contain no other bags.',
# ]
# rules = parse(input)
# count_parents('shiny gold', rules) # 4

def children(target, rules)
  rule = rules[target]
  return 1 if rule.empty?

  sum = 1
  rule.each do |k, v|
    child_count = children(k, rules)
    sum += v * child_count
  end
  sum
end

# part 2
# input = [
#   'dark red bags contain 2 dark orange bags.',
#   'dark orange bags contain 2 dark yellow bags.',
#   'dark yellow bags contain 2 dark green bags.',
#   'dark green bags contain 2 dark blue bags.',
#   'dark blue bags contain 2 dark violet bags.',
#   'dark violet bags contain no other bags.',
#   'shiny gold bags contain 2 dark red bags.',
# ]
# rules = parse(input)
# children('shiny gold', rules) - 1 # 126

input = File.readlines('day7-input.txt').map(&:strip)
rules = parse(input)
children('shiny gold', rules) - 1 # minus the bag itself
