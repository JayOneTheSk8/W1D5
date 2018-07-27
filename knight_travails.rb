require 'byebug'
require_relative 'skeleton/lib/00_tree_node.rb'

class KnightPathFinder

  attr_reader :root_node

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
    queue = [@root_node]

    until queue.empty?
      first = queue.shift
      # queue.push *new_move_positions(first)
      positions = new_move_positions(first.value)
      children = positions.map { |coordinate| PolyTreeNode.new(coordinate) }
      children.each { |child| first.add_child(child) }
      queue += children
    end

    return @root_node
  end

  def find_path(end_pos)
    # look for the final position in the tree (using dfs or bfs)
    @root_node.bfs(end_pos)
  end

  def trace_path_back
    # trace the path back to the root_node (parent)
  end

  def new_move_positions(current_position) # returns coordinates we have not visited
    possibilities = KnightPathFinder.valid_moves(current_position)
    valid = possibilities.reject { |coordinates| @visited_positions.include?(coordinates) }
    @visited_positions += valid
    valid
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
