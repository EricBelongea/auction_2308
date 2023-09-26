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

  # def sold_to
  #   winner = @bids.max_by { |item, bids| bids }.first
  # end

  def sold_to
    sorted_bids = @bids.sort_by { |attendee, bid| -bid }
    
    sorted_bids.each do |attendee, bid|
      if bid < attendee.budget
        attendee.budget -= bid
        return attendee 
      end
    end
    nil
  end
  
  
  

  def close_bidding
    @close_bidding = true
  end
end