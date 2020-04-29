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

end
