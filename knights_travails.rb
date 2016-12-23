require_relative 'skeleton/lib/00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  DELTAS = [
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1],
    [-2, 1],
    [-1, 2],
    [1, 2]
  ]
  attr_reader :visited_positions, :starting_point, :grid
  def initialize(starting_point)
    @visited_positions = []
    @starting_point = PolyTreeNode.new(starting_point)
    @grid = Array.new(8) { Array.new(8) { "_" } }
  end

  def find_path(end_point)
    raise "Not on board" if grid[end_point[0]][end_point[1]].nil?
    node = build_move_tree(end_point)
    move_map = []
    until node.parent.nil?
      move_map.unshift(node.value)
      node = node.parent
    end
    move_map.unshift(node.value)
    p move_map
  end

  def new_move_positions(node)
    row, col = node.value
    new_moves = []
    DELTAS.each do |delta|
      new_pos = [row + delta[0], col + delta[1]]
      # debugger
      unless grid[new_pos[0]].nil?
        unless grid[new_pos[0]][new_pos[1]].nil?
          new_moves << new_pos unless visited_positions.include?(new_pos)
        end
      end
    end
    new_moves
  end


  def build_move_tree(end_point)
    nodes_to_check_from = [starting_point] ## each val is node

    while nodes_to_check_from.length > 0
      node_to_check = nodes_to_check_from.shift
      visited_positions << node_to_check.value
      return node_to_check if node_to_check.value == end_point

      new_moves = new_move_positions(node_to_check)

      new_moves.each do |pos|
        new_node = PolyTreeNode.new(pos)
        new_node.parent = node_to_check
        return new_node if pos == end_point
        nodes_to_check_from << new_node
      end
    end
  end
end

if __FILE__ == $0
  kpf = KnightPathFinder.new([0, 0])
  kpf.find_path([7, 6])
  kpf = KnightPathFinder.new([0, 0])
  kpf.find_path([6, 2])
end
