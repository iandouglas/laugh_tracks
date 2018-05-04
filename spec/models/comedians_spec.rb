RSpec.describe Comedian do
  describe 'class methods' do
    it 'average_age' do
      ages = [35, 40]
      comedian1 = Comedian.create(name: 'Mitch Hedberg', age: ages[0])
      comedian2 = Comedian.create(name: 'Lynn Shawcroft', age: ages[1])
      avg = ages.sum.to_f / ages.length

      expect(Comedian.average_age).to eq(avg)
    end
  end
end
