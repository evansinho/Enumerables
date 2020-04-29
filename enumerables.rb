module Enumerable
  def my_each
    count = 0
    while count < self.length
      yield(self[count])
      count += 1
    end
    self
  end

  def my_each_with_index
    count = 0
    while count < self.length
      yield(self[count], count)
      count += 1
    end
    self
  end

  def my_select
    result = []
    my_each do |item|
      if yield(item)
        result.push(item)
      end
    end
    result
  end

  def my_all?
    result = true
    my_each do |item|
      if !yield(item)
        result = false
      end  
    end
    result
  end

  def my_any?
    result = false
    my_each do |item|
      if yield(item)
        result = true
      end  
    end
    result
  end

  def my_none?
    result = false
    my_each do |item|
      if !yield(item)
        result = true
      end
    end
    result
  end

  def my_count
    return self.length unless block_given?
    result = 0
    my_each do |item|
      if yield(item)
        result += 1
      end
    end
    result
  end

  def my_inject
    count = 1
    sum = self[0]
    result = 0
    while count < self.length
      result = yield(sum, self[count])
      sum = result
      count += 1
    end
      return result
    end
  end

  def multiply_els(array)
    array.my_inject { |result, num| result * num }
  end

end
