class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, amount)
    @bids[attendee] = amount
  end

  def current_high_bid
    high_roller = @bids.max_by { |item, bids| bids }.last
  end
end