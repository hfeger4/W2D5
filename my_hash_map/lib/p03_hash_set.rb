require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(value)
    unless include?(value)
      if num_buckets <= @count
        resize!
      end
      @count += 1
      self[value] << value
      return true
    end
    false
  end

  def remove(value)
    if include?(value)
      @count -= 1
      self[value].delete(value)
    end
  end

  def include?(value)
    self[value].include?(value)
  end

  private

  def [](value)
    # optional but useful; return the bucket corresponding to `num`
    @store[value.hash % num_buckets]
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
