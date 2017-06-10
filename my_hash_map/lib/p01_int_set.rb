require 'byebug'
class MaxIntSet
  attr_accessor :store
  attr_reader :max
  def initialize(max)
    @max = max
    @store = Array.new(max,false)
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if !num.between?(0,max)
    num.between?(0,max)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num%num_buckets] = num
    true
  end

  def remove(num)
    @store[num%num_buckets] = nil
  end

  def include?(num)
    self[num] == num
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :num_buckets, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      if num_buckets <= @count
        resize!
      end
      @count += 1
      self[num] << num
      true
    end
    false
  end

  def remove(num)
    if include?(num)
      @count -= 1
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    oldstore = @store
    @store = Array.new(num_buckets * 2){ Array.new }
    @count = 0
    oldstore.each do |bucket|
      bucket.each do |el|
        insert(el)
      end
    end
    @store
  end
end
