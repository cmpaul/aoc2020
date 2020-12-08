# --- Day 8: Handheld Halting ---

def execute(input)
  acc = 0
  cursor = 0
  visited = Set.new
  loop do
    if cursor >= input.size
      puts "Terminated successfully"
      return acc
    end

    if visited.include?(cursor)
      raise "Infinite loop at #{cursor}: #{acc}"
    end

    visited << cursor
    ins = input[cursor]
    command = ins[0..2]
    op = ins[4].to_sym
    val = ins[5..].to_i

    case command
    when 'nop'
      cursor += 1
    when 'acc'
      acc = acc.send(op, val)
      cursor += 1
    when 'jmp'
      cursor = cursor.send(op, val)
    else
      raise "Unknown command: #{command}"
    end
  end
end

# Part 1
input = [
  'nop +0',
  'acc +1',
  'jmp +4',
  'acc +3',
  'jmp -3',
  'acc -99',
  'acc +1',
  'jmp -4',
  'acc +6'
]
execute(input) # 5

# Part 2
input = File.readlines('day8-input.txt').map(&:strip)
execute(input)


def brute_fix(input)
  for i in 0..input.size
    next unless %w[nop jmp].include?(input[i][0..2])

    tmp_input = input.dup
    if input[i][0..2] == 'nop'
      tmp_input[i] = tmp_input[i].gsub('nop', 'jmp')
    elsif input[i][0..2] == 'jmp'
      tmp_input[i] = tmp_input[i].gsub('jmp', 'nop')
    end
    begin
      acc = execute(tmp_input)
      puts "Fixed by correcting line #{i}"
      return acc
    rescue => e
      puts "#{e.message}"
    end
  end
end

brute_fix(input)
