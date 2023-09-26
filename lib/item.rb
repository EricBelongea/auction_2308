class Item
  attr_reader :name, :bids, :close_bidding

  def initialize(name)
    @name = name
    @bids = {}
    @close_bidding = nil
  end

  def add_bid(attendee, amount)
    if @close_bidding != true
      @bids[attendee] = amount
    else
      "This bidding is closed"
    end
  end

  def current_high_bid
    high_roller = @bids.max_by { |item, bids| bids }.last
  end

  def close_bidding
    @close_bidding = true
  end
end