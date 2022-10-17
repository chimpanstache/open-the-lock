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
  until queue.empty?
    cur = queue.shift
    last_combo = [cur[0], cur[1], cur[2], cur[3]]
    return nb_of_moves(cur) if is_target?(last_combo, target)
    next_moves = all_next_moves(last_combo)
    moves_possible = filter_available_moves(next_moves, deadends_and_visited)
    next_moves.each do |move|
      deadends_and_visited << move.clone
      move << cur
      queue << move
    end
  end
  -1
end

def filter_available_moves(moves, deadends_and_visited)
  moves.delete_if { |move| deadends_and_visited.include?(move) }
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
    next_moves << [move, current_combination].transpose.map!(&:sum)
  end
  next_moves
end

def is_target?(last_combo, target)
  last_combo == target
end

def nb_of_moves(cur)
  cur.flatten.drop(4).count / 4
end

puts open_lock(["0201","0101","0102","1212","2002"], "0202")
