#frozen_string_literal: true
require 'set'
require 'byebug'

def open_lock(deadends, target)
  return -1 if deadends.include?("0000")
  deadends.map! { |st| st.chars.map!(&:to_i) } 
  target = target.chars.map!(&:to_i)

  visited = Set.new(deadends)
  visited.add([0,0,0,0])
  queue = [[0,0,0,0]]
  total = 0

  until queue.empty?
    queue.size.times do
      cur = queue.shift
      return total if cur == target
      [[1,0,0,0],
      [0,1,0,0],
      [0,0,1,0],
      [0,0,0,1],
      [-1,0,0,0],
      [0,-1,0,0],
      [0,0,-1,0],
      [0,0,0,-1]].each do |move|
        movie = [move, cur].transpose.map! { |m| m.sum % 10 }
        next if visited.include?(movie)
        visited.add(movie)
        queue.push(movie)
      end
    end
    total += 1
  end
  -1
end

puts open_lock(
["8887","8889","8878","8898","8788","8988","7888","9888"],
"8888")
