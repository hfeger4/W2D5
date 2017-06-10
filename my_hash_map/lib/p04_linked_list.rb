class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :end

  def initialize
    @head = Link.new(nil,nil)
    @end = Link.new(nil,nil)
    @head.next = @end

    @end.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @end.prev
  end

  def empty?
    return true if @head.next == @end
    false
  end

  def get(key)
    if include?(key)
      current_link = first
      until current_link.next.nil?
        return current_link.val if current_link.key == key
        current_link = current_link.next
      end
    end
  end

  def get_link(key)
    if include?(key)
      current_link = first
      until current_link.next.nil?
        return current_link if current_link.key == key
        current_link = current_link.next
      end
    end
  end

  def include?(key)
    current_link = first
    until current_link.next.nil?
      return true if current_link.key == key
      current_link = current_link.next
    end
    false
  end

  def append(key, val)
    last_one = last
    new_link = Link.new(key,val)
    @end.prev = new_link
    new_link.next = @end
    new_link.prev = last_one
    last_one.next = new_link
  end

  def update(key, val)
    if include?(key)
      current_link = first
      until current_link.next.nil?
        current_link.val = val if current_link.key == key
        current_link = current_link.next
      end
    end
  end

  def remove(key)
    if include?(key)
      current_link = get_link(key)
      previous_link = current_link.prev
      next_link = current_link.next
      previous_link.next = next_link
      next_link.prev = previous_link
    end
  end

  def each(&prc)
    current_link = first
    until current_link.next.nil?
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
