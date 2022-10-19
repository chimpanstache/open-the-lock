#frozen_string_literal: true

require 'byebug'

def open_lock(deadends, target)
  deadends.map! { |st| st.chars.map!(&:to_i) } 
  target = target.chars.map!(&:to_i)

  target_search_algo(deadends, target)
end

def target_search_algo(deadends, target)
  deadends_and_visited = deadends << [0,0,0,0]
  queue = [] << [0,0,0,0]
  total = 0

  until queue.empty?
    size = queue.length
    size.times do
      cur = queue.shift
      return total if cur == target
      next_moves = all_next_moves(cur)
      next_moves.each do |move|
        next if deadends_and_visited.include?(move)
        deadends_and_visited << move
        queue << move
      end
    end
    total += 1
  end
  -1
end

def all_next_moves(current_combination)
  moves_possible = [[1,0,0,0],
                    [0,1,0,0],
                    [0,0,1,0],
                    [0,0,0,1],
                    [-1,0,0,0],
                    [0,-1,0,0],
                    [0,0,-1,0],
                    [0,0,0,-1]]
  next_moves = []
  moves_possible.each do |move|
    movie = [move, current_combination].transpose.map!(&:sum)
    movie.map! { |m| (m == 10) ? m = 0 : m }  
    movie.map! { |m| (m == -1) ? m = 9 : m }
    next_moves << movie
  end
  next_moves
end

puts open_lock(["8887","8889","8878","8898","8788","8988","7888","9888"],
"8888")
