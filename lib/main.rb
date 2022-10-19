#frozen_string_literal: true

require 'byebug'

def open_lock(deadends, target)
  return -1 if deadends.include?("0000")
  deadends.map! { |st| st.chars.map!(&:to_i) } 
  target = target.chars.map!(&:to_i)

  target.first > 5 ? target_search_algo(deadends, target, [0,0,0,0]) : target_search_algo(deadends, [0,0,0,0], target)
end

def target_search_algo(deadends, target, match)
  deadends_and_visited = deadends << target
  queue = [] << target
  total = 0

  until queue.empty?
    size = queue.length
    size.times do
      cur = queue.shift
      return total if cur == match
      all_next_moves(cur, deadends_and_visited, queue)
    end
    total += 1
  end
  -1
end


def all_next_moves(current_combination, visited, queue)
  [[1,0,0,0],
  [0,1,0,0],
  [0,0,1,0],
  [0,0,0,1],
  [-1,0,0,0],
  [0,-1,0,0],
  [0,0,-1,0],
  [0,0,0,-1]].each do |move|
    movie = [move, current_combination].transpose.map! { |m| m.sum % 10 }
    next if visited.include?(movie)
    visited.push(movie)
    queue.push(movie)
  end
end

puts open_lock(["2111","2202","2210","0201","2210"],
"2201")
