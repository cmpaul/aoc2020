# --- Day 4: Passport Processing ---
REQUIRED_KEYS = %w[byr ecl eyr hcl hgt iyr pid].sort
OPTIONAL_KEYS = %w[cid].sort
HEIGHT_REGEX = /\A(?<height>\d+)(?<unit>cm|in)\z/
HAIR_COLOR_REGEX = /\A#[0-9a-f]{6}\z/
VALID_EYE_COLORS = %w[amb blu brn gry grn hzl oth]
PASSPORT_REGEX = /\A\d{9}\z/

def valid_keys?(passport)
  (passport.keys - OPTIONAL_KEYS).sort == REQUIRED_KEYS
end

def valid_height?(str)
  matches = str.match(HEIGHT_REGEX)
  return false if matches.nil?
  unit = matches['unit']
  height = matches['height'].to_i
  if unit == 'cm'
    return height >= 150 && height <= 193
  elsif unit == 'in'
    return height >= 59 && height <= 76
  end
  false
end

# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.
def valid_values?(passport)
  return false unless passport['byr'].to_i >= 1920 && passport['byr'].to_i <= 2002
  return false unless passport['iyr'].to_i >= 2010 && passport['iyr'].to_i <= 2020
  return false unless passport['eyr'].to_i >= 2020 && passport['eyr'].to_i <= 2030
  return false unless valid_height?(passport['hgt'])
  return false unless passport['hcl'].match?(HAIR_COLOR_REGEX)
  return false unless VALID_EYE_COLORS.include?(passport['ecl'])
  return false unless passport['pid'].match?(PASSPORT_REGEX)
  true
end

def valid?(passport)
  valid_keys?(passport) && valid_values?(passport)
end

def count_valid(input)
  current_passport = {}
  passports = input.each_with_object([]) do |line, acc|
    if line == ''
      acc << current_passport
      current_passport = {}
    else
      line.split(' ').map { |kvp| kvp.split(':') }.each do |(key, value)|
        current_passport[key] = value
      end
    end
  end << current_passport

  passports.count { |p| valid?(p) }
end

# input = [
#   'ecl:gry pid:860033327 eyr:2020 hcl:#fffffd',
#   'byr:1937 iyr:2017 cid:147 hgt:183cm',
#   '',
#   'iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884',
#   'hcl:#cfa07d byr:1929',
#   '',
#   'hcl:#ae17e1 iyr:2013',
#   'eyr:2024',
#   'ecl:brn pid:760753108 byr:1931',
#   'hgt:179cm',
#   '',
#   'hcl:#cfa07d eyr:2025 pid:166559648',
#   'iyr:2011 ecl:brn hgt:59in',
# ]
# count_valid(input) # 2

# Part 2
input = File.readlines('day4-input.txt').map(&:strip)
count_valid(input)

# Invalid passports
# input = [
#   'eyr:1972 cid:100',
#   'hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926',
#   '',
#   'iyr:2019',
#   'hcl:#602927 eyr:1967 hgt:170cm',
#   'ecl:grn pid:012533040 byr:1946',
#   '',
#   'hcl:dab227 iyr:2012',
#   'ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277',
#   '',
#   'hgt:59cm ecl:zzz',
#   'eyr:2038 hcl:74454a iyr:2023',
#   'pid:3556412378 byr:2007',
# ]

# Valid passports
# input = [
#   'pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980',
#   'hcl:#623a2f',
#   '',
#   'eyr:2029 ecl:blu cid:129 byr:1989',
#   'iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm',
#   '',
#   'hcl:#888785',
#   'hgt:164cm byr:2001 iyr:2015 cid:88',
#   'pid:545766238 ecl:hzl',
#   'eyr:2022',
#   '',
#   'iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719',
# ]
