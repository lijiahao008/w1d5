class PolyTreeNode
  require 'byebug'

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def parent=(el)
    # return nil if el.nil?
    unless el == @parent
      unless @parent.nil? #|| el.nil?
        # debugger
        @parent.children.delete(self)
      end
      @parent = el
      el.add_child(self) unless el.nil?
    end
  end

  def children
    @children
  end

  def value
    @value
  end


  def add_child(el)
    unless @children.include?(el)
      @children << el
      el.parent = self
    end
  end

  def remove_child(el)
    # debugger
    if @children.include?(el)
      @children.delete(el)
      el.parent = nil
    else
      raise "Not my child, not my problem"
    end
  end

  def dfs(target_value)
    return self if value == target_value
    children.each do |child|
      found = child.dfs(target_value)
      return found unless found == nil
    end
    nil
  end


## node value if found to match target_value
## return addional children to check
### nil if no additional children to check

  def bfs(target_value)
    child_arr = [self]
    # children.each {|child| children_arr << child }
    while child_arr.length > 0
      node_to_check = child_arr.shift
      return node_to_check if node_to_check.value == target_value
      node_to_check.children.each { |child| child_arr << child }
    end
    nil
  end
end
