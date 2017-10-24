require_relative "static_array"

class RingBuffer
  attr_reader :length

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
    @store[(@start_location + index)] = val
  end


  def push(val)
    if @length == @capacity
      self.resize!
    end
    @store[(@start_location + @length) % @capacity] = val
    @length += 1
  end

  def pop
    if @length == 0
      raise "index out of bounds"
    end
    @length -= 1
    ending_pos = (@start_location + @length) % @capacity
    @store[ending_pos]
  end

  def unshift(val)
    if @length == @capacity
      self.resize!
    end
    @start_location -= 1
    @store[@start_location % @capacity] = val
    @length += 1
  end


  def shift
    if @length == 0
      raise "index out of bounds"
    end
    shifted_el = @store[@start_location]
    @start_location = (@start_location + 1) % @capacity
    @length -= 1

    shifted_el
  end






  protected
  attr_accessor :capacity, :store, :start_location
  attr_writer :length

  def resize!
    @capacity *= 2
    new_arr = Array.new(@capacity)
    (0...@length).each do |i|
      new_arr[i] = @store[(@start_location + i) % (@capacity/2)]
    end
    @store = new_arr
    @start_location = 0
  end
end
