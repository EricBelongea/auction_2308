require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')

    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

    @auction = Auction.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@auction).to be_a Auction
    end

    it 'has attributes' do
      expect(@auction.items).to eq([])
    end
  end

  describe '#Add_items' do
    it 'listing added items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      
      expect(@auction.items).to eq([@item1, @item2])
      expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe '#adding bids' do #Also done in Item class
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

  describe '#affirming setup was correct for bidding' do
    it 'has the items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      expect(@auction.items).to eq([@item1, @item2, @item3, @item4, @item5])
    end
  end

  describe '#Popular_items' do
    it 'has an unpopular item' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 20)
      @item1.add_bid(@attendee2, 22)
      @item4.add_bid(@attendee3, 50)
      
      expect(@auction.unpopular_item).to eq([@item2, @item3, @item5])
      
      @item3.add_bid(@attendee2, 15)
      
      expect(@auction.unpopular_item).to eq([@item2, @item5])
    end
  end

  describe '#potential_revenue' do
    it 'grabs highest bids' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 20)
      @item1.add_bid(@attendee2, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expect(@auction.potential_revenue).to eq(87)
    end
  end

end