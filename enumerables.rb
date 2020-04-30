# rubocop:disable Metrics/ModuleLength
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
      return false if block_given? && !yield(i)

      if !block_given? && input.nil?
        return false unless x
      elsif input
        return false unless input_check(x, input)
      end
    end
    true
  end

  def my_any?(input = nil)
    my_each do |x|
      return true if block_given? && yield(x)

      if !block_given? && input.nil?
        return true if x
      elsif !block_given? && input
        return true if input_check(x, input)
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
        return false if input_check(x, input)
      end
    end
    true
  end

  def my_count(input = nil)
    count = 0
    my_each do |x|
      if block_given? && input.nil?
        count += 1 if yield(x)
      elsif x && !input.nil?
        count += 1 if x == input
      elsif input.is_a?(Integer)
        count += 1
      else
        count = length
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

  def input_check(item, input)
    if input.class == Regexp
      return true if item.to_s.match(input)
    elsif input.class == Class
      return true if item.instance_of? input
    elsif input.class == String || input.class == Integer || input.class == Symbol
      return true if item == input
    end
  end
end

def multiply_els(array)
  array.my_inject { |result, x| result * x }
end

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:enable Metrics/ModuleLength

# puts 'my_each vs. each'
# [1, 2, 3, 4, 5].my_each { |item| print item * 2 }
# puts ''
# [1, 2, 3, 4, 5].each { |item| print item * 2 }
# puts ''

# puts 'my_each_with_index vs. each_with_index'
# [1, 2, 3, 4, 5].my_each_with_index { |item, index| print [item, index] }
# puts ''
# [1, 2, 3, 4, 5].each_with_index { |item, index| print [item, index] }
# puts ''

# puts 'my_select vs. select'
# print [1, 2, 3, 4, 5].my_select(&:even?)
# puts ''
# print [1, 2, 3, 4, 5].select(&:even?)
# puts ''

# puts 'my_all? vs. all?'
# puts [1, 2, 3].my_all?(5)
# puts [1, 2, 3].all?(5)

# puts 'my_any? vs. any?'
# puts %w[dog door rod blade].my_any? (/t/)
# puts %w[dog door rod blade].any? (/t/)

# puts 'my_none? vs. none?'
# puts %w[dog door rod blade].my_none?(/d/)
# puts %w[dog door rod blade].none?(/d/)

puts 'my_count vs. count'
puts [1, 1, 2 ,3].my_count(1)
puts [1, 1, 2 ,3].my_count
puts [1, 1, 2 ,3].count(1)
puts [1, 1, 2 ,3].count

# puts 'my_map vs. map'
# print [1, 2, 3, 4, 5].my_map { |num| num * 2 }
# puts ''
# print [1, 2, 3, 4, 5].map { |num| num * 2 }
# puts ''

# puts 'my_inject vs. inject'
# puts [1, 2, 3, 4, 5].my_inject { |sum, num| sum * num }
# puts [1, 2, 3, 4, 5].inject { |sum, num| sum * num }
# puts 'initial = 2'
# puts [1, 2, 3, 4, 5].my_inject(2) { |sum, num| sum * num }
# puts [1, 2, 3, 4, 5].inject(2) { |sum, num| sum * num }

# puts 'multiply_els'
# puts multiply_els([2, 4, 5])
