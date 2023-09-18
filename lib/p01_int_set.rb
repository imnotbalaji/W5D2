require "byebug"
class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    if num > store.length || num < 0
      raise "Out of bounds" 
      return false 
    end 
    store[num] = true
  end

  def remove(num)
    if num > store.length || num < 0
      raise "Out of bounds" 
      return false 
     
    end 
    store[num] = false 
  end

  def include?(num)
    if num > store.length || num < 0
      raise "Out of Bounds" 
      return false
    end 
    store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end

class IntSet
  attr_reader :store, :num_buckets
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  
  end


  def include?(num)
    index =  num % num_buckets
    if self[index].include?(num)
      return true
    else 
      return false 
    end 
  end

  def insert(num)
  
    index =  num % num_buckets
    self[index] << (num)
  end

  def remove(num)
    index = num%num_buckets
    self[index].delete_if {num}
  end

 

  private

  def [](num)
    store[num]
     # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  
  attr_accessor :count, :store


  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    index =  num % num_buckets
    return false if self[index].include?(num)
    self[index] << (num)
    self.count +=1   
   self.resize! if self.count > num_buckets
  end

  def remove(num)
    index = num%num_buckets
    return false if !self[index].include?(num)
    self[index].delete_if {num}
    self.count -=1 

  end

  def include?(num)
    index =  num % num_buckets
    if self[index].include?(num)
      return true
    else 
      return false 
    end 
  end
  # def inspect 
  # end 

  private

  def num_buckets
    @store.length
  end

  def resize!
    # debugger
    new_bucket_size = 2 * num_buckets
    new_store = Array.new(new_bucket_size) {Array.new}
    store.each do |bucket|
      bucket.each do |element|
        new_bucket = element % new_bucket_size
        new_store[new_bucket] << element
      end 
    end 
    self.store = new_store # why does this not work ?
  end

  def [](num)
    store[num]
    # optional but useful; return the bucket corresponding to `num`
  end
end