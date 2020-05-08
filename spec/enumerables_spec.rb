require './lib/enumerables'

describe Enumerable do
  describe 'my_each' do
    it 'should display all numbers in the specified array' do
      expect { |num| [1, 2, 3, 4, 5].my_each(&num) }.to yield_successive_args(1, 2, 3, 4, 5)
    end

    it 'should return an enum if no block is given' do
      expect([1, 2, 3, 4, 5].my_each.class).to eql(Enumerator)
    end
  end

  describe 'my_each_with_index' do
    it 'should display all numbers in the specified array' do
      arr = []
      [4, 5].my_each_with_index { |num, index| arr.push([num, index]) }
      expect(arr).to eql([[4, 0], [5, 1]])
    end

    it 'should return an enum if no block is given' do
      expect([1, 2, 3, 4, 5].my_each_with_index.class).to eql(Enumerator)
    end
  end

  describe 'my_select' do
    it 'should return an array of elements that meet a specified condition' do
      arr = [1, 2, 3, 4, 5].my_select(&:odd?)

      expect(arr).to eql([1, 3, 5])
    end

    it 'should return an enum if no block is given' do
      expect([1, 2, 3, 4, 5].my_select.class).to eql(Enumerator)
    end
  end

  describe 'my_all?' do
    it 'should return true if a block is given and all elements meet the specified condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'should return false if a block is given and all elements do not meet the specified condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'should return false if all elements do not belong to a specified class' do
      expect([1, 'String', 3.14].my_all?(Numeric)).to eql(false)
    end

    it 'should return true if all elements match a regular expression' do
      expect(%w[ant bat cat].my_all?(/t/)).to eql(true)
    end

    it 'should return false if all elements do not belong to a specified class' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'should return true if all elements are equal to an argument' do
      expect([1, 1, 1].my_all?(1)).to eql(true)
    end

    it 'should return false if all elements are not equal to an argument' do
      expect([1, 11, 111].my_all?(1)).to eql(false)
    end

    it 'should return true if no block is given but the array has no falsey value' do
      expect(%w[ant bear cat].my_all?).to eql(true)
    end

    it 'should return false if no block is given but the array has a falsey value' do
      expect([1, nil, 3].my_all?).to eql(false)
    end
  end

  describe 'my_any?' do
    it 'should return true if a block is given and any element meets the specified condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length > 3 }).to eql(true)
    end

    it 'should return false if a block is given and no element meets the specified condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length == 1 }).to eql(false)
    end

    it 'should return false if no element belongs to a specified class' do
      expect(%w[ant bear cat].my_any?(Numeric)).to eql(false)
    end

    it 'should return true if any element matches a regular expression' do
      expect(%w[ant bear barn].my_any?(/t/)).to eql(true)
    end

    it 'should return false if no element matches a regular expression' do
      expect(%w[song bro from].my_any?(/t/)).to eql(false)
    end

    it 'should return true if any element is equal to specified argument' do
      expect([1, 2, 3].my_any?(1)).to eql(true)
    end

    it 'should return false if no element is equal to specified argument' do
      expect([11, 11, 111].my_any?(1)).to eql(false)
    end

    it 'should return true if at least one element in the array is truthy' do
      expect([1, nil, nil].my_any?).to eql(true)
    end

    it 'should return false if all elements evaluate to falsey' do
      expect([nil, nil, nil].my_any?).to eql(false)
    end
  end
end
