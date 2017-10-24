require_relative "static_array"

class RingBuffer
  attr_reader :start_location, :length

  def initialize
    @start_location = 0
    @capacity = 8
    @length = 0

    @store = Array.new(@capacity)
  end


  def [](index)
    if index >= @length || @store.empty?
      raise "index out of bounds"
    end
    @store[(@start_location + index) % @capacity]
  end

  def []=(index, val)
    if index > @length
      raise "index out of bounds"
    end
    @store[(@start_location + index) % @capacity] = val
  end
  

  def push(val)
    if @length == @capacity
      self.resize!
    end
    @store[(@start_location + length) % @capacity] = val
    @length += 1
  end

  def pop
    @length -= 1
    ending_pos = (@start_location + @length) % @capacity
    @store = @store[@start_location..ending_pos]
    @store[ending_pos]
  end






  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def resize!
    @capacity *= 2
    new_arr = Array.new(@capacity)
    @store.each do |el|
      new_arr << el
    end
    @store = new_arr
  end
end
