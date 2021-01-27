# --- Day 14: Docking Data ---

MEM_REGEX = /\Amem\[(?<addr>\d+)\] = (?<val>\d+)\z/

def apply(mask, val)
  binary = val.to_s(2).rjust(36, '0')
  mask.split('').each_with_index do |m, i|
    next if m == 'X'
    binary[i] = '1' if m == '1'
    binary[i] = '0' if m == '0'
  end
  binary.to_i(2)
end

def build(input)
  mask = ''
  input.each_with_object({}) do |line, acc|
    if line.start_with?('mask = ')
      mask = line[7..]
    else
      matcher = line.match(MEM_REGEX)
      addr = matcher[:addr].to_i
      val = matcher[:val].to_i
      acc[addr] = apply(mask, val)
    end
  end
end

def sum(input)
  memory = build(input)
  memory.values.reject(&:zero?).inject(:+)
end

input = [
  'mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X',
  'mem[8] = 11',
  'mem[7] = 101',
  'mem[8] = 0',
]
sum(input)
