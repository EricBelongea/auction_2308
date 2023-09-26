require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@item1).to be_a Item
    end

    it 'has attributes' do
      expect(@item1.name).to eq("Chalkware Piggy Bank")
      expect(@item2.name).to eq('Bamboo Picture Frame')
    end
  end

  describe '#adding bids' do
    it 'creates variable' do
      expect(@item1.bids).to eq({})
    end

    it 'add_bid' do
      @item1.add_bid(@attendee1, 20)
      expect(@item1.bids).to eq({@attendee1 => 20})
      
      @item1.add_bid(@attendee2, 22)
      expect(@item1.bids).to eq({@attendee1 => 20, @attendee2 => 22})
    end

    it 'has a highest bid' do
      @item1.add_bid(@attendee1, 20)
      @item1.add_bid(@attendee2, 22)
      
      expect(@item1.current_high_bid).to eq(22)
    end
  end
end