module Enumerable
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_each
    x = 0
    return to_enum unless block_given?
    list = is_a?(Range) ? to_a : self
    while x < list.length
      yield(list[x])
      x += 1
    end
    list
  end

  def my_each_with_index
    x = 0
    return to_enum unless block_given?
    list = is_a?(Range) ? to_a : self
    while x < list.length
      yield(list[x], x)
      x += 1
    end
    list
  end

  def my_select
    result = []
    return to_enum unless block_given?

    my_each do |x|
      result << x if yield(x)
    end
    result
  end

  def my_all?(input = nil)
    my_each do |x|
      return false if block_given? && !yield(x)

      if !block_given? && input.nil?
        return false unless x
      elsif input
        return false
      end
    end
    true
  end

  def my_any?(input = nil)
    my_each do |x|
      return false if block_given? && yield(x)

      if !block_given? && input.nil?
        return true if x
      elsif !block_given? && input
        return true
      end
    end
    false
  end

  def my_none?(input = nil)
    my_each do |x|
      return false if block_given? && yield(x)

      if !block_given? && input.nil?
        return false if x
      elsif !block_given? && input
        return false
      end
    end
    true
  end

  def my_count(input = nil)
    count = 0
    my_each do |x|
      if block_given? && input.nil?
        count += 1 if yield(x)
      elsif x && input.nil?
        count += 1
      elsif input.is_a?(Integer)
        count += 1
      end
    end
    count
  end

  def my_map
    result = []
    my_each do |x|
      return to_enum unless block_given?

      result << yield(x) || result << proc.call(x) if block_given?
    end
    result
  end

  # def my_inject(initial = nil)
  #   result = initial.nil? ? to_a[self[0]] : initial
  #   index = initial.nil? ? 1 : 0
  #   self[index...length].my_each do |item|
  #     result = yield(result, item)
  #   end
  #   result
  # end

  def my_inject(*args)
    list = is_a?(Range) ? to_a : self
    reduce = args[0] if args[0].is_a?(Integer)
    operator = args[0].is_a?(Symbol) ? args[0] : args[1]

    if operator
      list.my_each { |x| reduce = reduce ? reduce.send(operator, x) : x }
      return reduce
    end
    list.my_each { |x| reduce = reduce ? yield(reduce, x) : x }
    reduce
  end

  def multiply_els(array)
    array.my_inject { |result, x| result * x }
  end
end
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

puts 'my_each vs. each'
[1, 2, 3, 4, 5].my_each { |item| print item * 2 }
puts ''
[1, 2, 3, 4, 5].each { |item| print item * 2 }
puts ''

puts 'my_each_with_index vs. each_with_index'
[1, 2, 3, 4, 5].my_each_with_index { |item, index| print [item, index] }
puts ''
[1, 2, 3, 4, 5].each_with_index { |item, index| print [item, index] }
puts ''

puts 'my_select vs. select'
print [1, 2, 3, 4, 5].my_select(&:even?)
puts ''
print [1, 2, 3, 4, 5].select(&:even?)
puts ''

puts 'my_all? vs. all?'
puts [1, 2, 3, 4, 5].my_all? { |num| num < 10 }
puts [1, 2, 3, 4, 5].all? { |num| num < 10 }

puts 'my_any? vs. any?'
puts [1, 2, 3, 4, 5].my_any? { |num| num > 3 }
puts [1, 2, 3, 4, 5].any? { |num| num > 3 }

puts 'my_none? vs. none?'
puts [1, 2, 3, 4, 5].my_none? { |num| num > 3 }
puts [1, 2, 3, 4, 5].none? { |num| num > 3 }

puts 'my_count vs. count'
puts [1, 2, 3, 4, 5].my_count(&:even?)
puts [1, 2, 3, 4, 5].my_count
puts [1, 2, 3, 4, 5].count(&:even?)
puts [1, 2, 3, 4, 5].count

puts 'my_map vs. map'
print [1, 2, 3, 4, 5].my_map { |num| num * 2 }
puts ''
print [1, 2, 3, 4, 5].map { |num| num * 2 }
puts ''

puts 'my_inject vs. inject'
puts [1, 2, 3, 4, 5].my_inject { |sum, num| sum * num }
puts [1, 2, 3, 4, 5].inject { |sum, num| sum * num }
puts 'initial = 2'
puts [1, 2, 3, 4, 5].my_inject(2) { |sum, num| sum * num }
puts [1, 2, 3, 4, 5].inject(2) { |sum, num| sum * num }

puts 'multiply_els'
puts multiply_els([2,4,5])
