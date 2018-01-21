$LEFT = 0
$RIGHT = 1

class Node

  attr_reader :character, :left_child, :right_child

  # def initialize
  #   @character = nil;
  #   @left_child = nil;
  #   @right_child = nil;
  # end

  def is_leaf?
    !@character.nil? && !has_left_child? && !has_right_child?
  end

  def has_left_child?
    !@left_child.nil?
  end

  def has_right_child?
    !@right_child.nil?
  end

  def create_left_child
    @left_child = Node.new
  end

  def create_right_child
    @right_child = Node.new
  end

  def insert(character, path)
    # PATH IS OVER, INSERT CHARACTER AT CURRENT NODE
    if path.empty?
      @character = character
      return
    end

    direction = path.shift
    # PATH DIRECTS LEFT
    if direction == $LEFT
      # IF NODE DOESN'T HAVE LEFT NODE, CREATE ONE
      if !has_left_child? then create_left_child end
      @left_child.insert(character, path)
      return
    end

    # PATH DIRECTS RIGHT
    if direction == $RIGHT
      # IF NODE DOESN'T HAVE RIGHT NODE, CREATE ONE
      if !has_right_child? then create_right_child end
      @right_child.insert(character, path)
      return
    end

    # PATH ISN'T OVER, PATH DOESN'T DIRECT LEFT OR RIGHT
    raise "invalid path"
  end

  def print_tree
    print @character

    if has_left_child? then @left_child.print_tree end
    if has_right_child? then @right_child.print_tree end
  end
end

def main
  root = Node.new


  n = gets.chomp.to_i
  n.times do
    code_part = gets.chomp.split("")
    character = code_part.shift

    # INSERT CHARACTER INTO TREE USING READ DIRECTIONS
    root.insert(character, code_part.map { |e| e.to_i })
  end


  active_node = root
  code = gets.chomp.split("").map { |e| e.to_i }
  code.each do |direction|

    if direction == $LEFT then active_node = active_node.left_child
    elsif direction == $RIGHT then active_node = active_node.right_child end

    if active_node.is_leaf?
      print active_node.character
      active_node = root
    end

  end

  puts

end

main
