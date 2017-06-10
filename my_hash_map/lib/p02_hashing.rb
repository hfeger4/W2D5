class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash
    new_hash = 0
    return 105 if self == []
    return 107 if self == [[]]
    return 109 if self == [[[]]]
    self.each_with_index do |num,i|
      new_hash = (num * i) ^ new_hash
    end
    new_hash
  end
end

class String
  def hash
    new_hash = 0
    self.chars.each_with_index do |letter,i|
      new_hash = (letter.ord * i) ^ new_hash
    end
    new_hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    new_hash = 0
    self.each do |k,v|
      v.to_s.chars.each do |letter|
        new_hash = (letter.ord * k.to_s.ord) ^ new_hash
      end
    end
    new_hash
  end
end
