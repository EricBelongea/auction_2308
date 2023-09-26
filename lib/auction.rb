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
    unpopular = @items.flat_map do |item, bid|
      if item.bids == {}
        item
      end
    end.compact
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
    bidders = @items.flat_map do |item|
      list = item.bids.keys
      list.flat_map do |index|
        index.name
      end
    end.uniq
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

  def close_auction
    sold_items ={}

    @items.each do |item|
      # require 'pry'; binding.pry
      if item.bids != {}
        sold_items[item] = item.sold_to
      elsif item.sold_to == nil
        ## return "Not Sold"
        sold_items[item] = "Not Sold"
      end
      # require 'pry'; binding.pry
    end
    sold_items
  end
end