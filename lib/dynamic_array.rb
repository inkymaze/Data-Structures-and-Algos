require_relative "static_array"

class DynamicArray
  attr_reader :length



  def initialize
    @length = 0
    @capacity = 8
    @store = Array.new
  end

  def [](index)
    if index >= @length || @store.empty?
      raise "index out of bounds"
    end
    @store[index]
  end

  def []=(index, value)
    if index > @length
      raise "index out of bounds"
    end
    @store[index] = value
  end

  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
  end

  def push(val)
    if @length == @capacity
      self.resize!
    end
    @store[@length] = val
    @length += 1
  end

  def shift
    if @length == 0
      raise "index out of bounds"
    end
    @store = @store[1..-1]
    @length -= 1
  end

  def unshift(val)
    if @length == @capacity
      self.resize!
    end
    new_arr = [val]
    @store.each do |el|
      new_arr << el
    end
    @store = new_arr
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def resize!
    @capacity *= 2
    new_arr = Array.new(@capacity)
    @store.each do |el|
      new_arr[el] = @store[el]
    end
    @store = new_arr
  end

end
