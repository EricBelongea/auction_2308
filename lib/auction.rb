class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.flat_map { |item| item.name }
  end

  def unpopular_item
    unpopular = []
    @items.each do |item, bid|
      if item.bids == {}
        unpopular << item
      end
    end
    unpopular
  end
  
  def potential_revenue
    revenue = 0
    @items.each do |item|
      if item.bids != {}
        revenue += item.current_high_bid
      end
    end
    revenue
  end
end