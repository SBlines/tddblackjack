require './deck'

describe Deck do 
  it "should have 52 cards after initialization" do
    d = Deck.new
    expect(d.length).to eq(52)
  end
end