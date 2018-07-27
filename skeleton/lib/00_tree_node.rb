class PolyTreeNode

  # attr_accessor :parent, :children, :value
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = new_parent
    new_parent.children << self unless new_parent.nil? || new_parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if @children.include?(child_node)
      child_node.parent = nil
    else
      raise "Node is not a child."
    end
  end

  def dfs(target_val)
    # Base case: Whenever a node is called, its value is checked to see if it matches
    return self if self.value == target_val

    # If the base case isn't true it will iterate over the node's children to see if it exists there
    self.children.each do |child|
      # memoization
      child_search = child.dfs(target_val)
      # if the find is nil, that means the method got to the bottom
      # and could not find the target value
      return child_search unless child_search.nil?
    end

    # result
    return nil

    # return target_val's parent if self is equal to target_val
  end

  def bfs(target_val)
    queue = [self]

    until queue.empty?
      return queue.first if queue.first.value == target_val

      queue.push *queue.first.children unless queue.first.children.empty?
      queue.shift
    end

    return nil # self if queue.first.value == target_val
  end
end
