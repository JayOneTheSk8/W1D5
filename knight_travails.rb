require 'byebug'
require_relative 'skeleton/lib/00_tree_node.rb'

class KnightPathFinder

  DELTA = [
    [-1, -2],
    [1, 2],
    [-1, 2],
    [1, -2],
    [-2, -1],
    [2, 1],
    [-2, 1],
    [2, -1]
  ]

  def initialize(position = [0,0])
    @root_node = PolyTreeNode.new(position)
    @visited_positions = [position]
    build_move_tree
    p "New Moves:"
    p build_move_tree
  end

  def build_move_tree
    start_pos = @root_node.value
    new_move_positions(start_pos)
  end

  def find_path

  end

  def new_move_positions(current_position) # returns coordinates we have not visited
    possibilities = KnightPathFinder.valid_moves(current_position)
    possibilities.reject { |coordinates| @visited_positions.include?(coordinates) }
  end

  def self.valid_moves(position) # moves that are possible on the board but not necessarily valid
    possible_moves = []

    DELTA.each do |move|
      pos = []
      move.each_with_index do |axis, index|
        pos << axis + position[index]
      end
      possible_moves << pos
    end

    possible_moves.select do |movement|
      movement.none? { |axis| axis < 0 || axis > 7 }
    end
  end

end
