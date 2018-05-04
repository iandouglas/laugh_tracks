=begin
As a visitor,
When I visit `/comedians`
Then I see a list of comedians with the following
information for each comedian:
  * Name
  * Age
=end

RSpec.describe 'Visitor' do
  context 'when i visit /comedians' do
    it 'should show me all comedians and their age' do
      comedian1 = Comedian.create(name: 'Mitch Hedberg', age: 35)
      comedian2 = Comedian.create(name: 'Lynn Shawcroft', age: 40)

      visit '/comedians'

      expect(page).to have_content(comedian1.name)
      expect(page).to have_content(comedian1.age)
      expect(page).to have_content(comedian2.name)
      expect(page).to have_content(comedian2.age)
    end

    it 'should show me all specials for a comedian' do
      comedian1 = Comedian.create(name: 'Mitch Hedberg', age: 35)
      comedian2 = Comedian.create(name: 'Lynn Shawcroft', age: 40)
      special1 = comedian1.specials.create(name: 'Los Enchilidas?')
      special2 = comedian2.specials.create(name: 'Do You Believe in Gosh? CD Release')

      visit '/comedians'

      expect(page).to have_content(special1.name)
      expect(page).to have_content(special2.name)
    end

    it 'should show me the average age of all comics' do
      ages = [35, 40]
      comedian1 = Comedian.create(name: 'Mitch Hedberg', age: ages[0])
      comedian2 = Comedian.create(name: 'Lynn Shawcroft', age: ages[1])
      avg = ages.sum.to_f / ages.length

      visit '/comedians'

      within('#average') do
        expect(page).to have_content("Average age: #{avg}")
      end
    end

    it 'should show a count of specials for each comic' do
      comedian1 = Comedian.create(name: 'Mitch Hedberg', age: 35)
      comedian2 = Comedian.create(name: 'Lynn Shawcroft', age: 40)
      special1 = comedian1.specials.create(name: 'Los Enchilidas?')

      visit '/comedians'

      within('#comedian_1') do
        expect(page).to have_content("Number of Specials: #{comedian1.specials.count}")
      end
      within('#comedian_2') do
        expect(page).to have_content("Number of Specials: #{comedian2.specials.count}")
      end
    end

  end

  context 'when I visit /comedians?age=34' do
    it 'should only show me comedians who are 34' do
      comedian1 = Comedian.create(name: 'Mitch Hedberg', age: 34)
      comedian2 = Comedian.create(name: 'Lynn Shawcroft', age: 40)

      visit '/comedians?age=34'

      expect(page).to have_content(comedian1.name)
      expect(page).to_not have_content(comedian2.name)
    end
  end
end
