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
end
