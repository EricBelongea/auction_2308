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

  def bidders
    bidders = []
    @items.flat_map do |item|
      list = item.bids.keys
      list.each do |index|
        bidders << index.name
      end
    end
    bidders.uniq
  end

  def bidder_info
    bidder_info = {}

    @items.each do |item|
      item.bids.each do |bidder, bid|
        bidder_info[bidder] ||= { budget: 0, items: []}
        bidder_info[bidder][:budget] = bidder.budget
        bidder_info[bidder][:items] << item
      end
    end
    bidder_info
  end
end