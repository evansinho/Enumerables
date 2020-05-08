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

  
end