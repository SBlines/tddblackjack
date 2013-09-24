require './black_jack'
require './person'
require './deck'


describe Person do
before do 
  @person=Person.new("David")
end

  it "can be initialized with an optional name argument" do
    expect(@person.name).to eq("David")
  end

  it "should be able to set an strategy attribute" do 
    @person.strategy = "greedy"
    expect(@person.strategy).to eq("greedy")
  end

  it "holds cards in an array called cards" do
    expect(@person.cards).to be_instance_of(Array)
  end

  it "can get a total point value of its cards using .total" do
    @person.cards = [Deck::Card[:value => 11, :suit => :diamonds, :card => "ace"],
    Deck::Card[:value => 9, :suit => :hearts, :card => 9]]
    expect(@person.total).to eq(20)
  end

  it "knows if it has blackjack using .blackjack?" do 
    @person.cards = [Deck::Card[:value => 11, :suit => :diamonds, :card => "ace"],
    Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
    expect(@person.blackjack?).to eq(true)
  end

  it "knows if it has busted using .busted?" do
    @person.cards = [Deck::Card[:value => 8, :suit => :diamonds, :card => 8],
    Deck::Card[:value => 8, :suit => :hearts, :card => 8],
    Deck::Card[:value => 9, :suit => :hearts, :card => 9]]
    expect(@person.busted?).to be_true
  end

  it "knows how to use a soft ace" do 
    @person.cards = [Deck::Card[:value => 11, :suit => :diamonds, :card => "ace"],
      Deck::Card[:value => 8, :suit => :hearts, :card => 8],
      Deck::Card[:value => 9, :suit => :hearts, :card => 9]]
    expect(@person.busted?).to be_false
  end

  it "prints out its name and card total using .to_s" do
    @person.cards = [Deck::Card[:value => 11, :suit => :diamonds, :card => "ace"],
      Deck::Card[:value => 8, :suit => :hearts, :card => 8],
      Deck::Card[:value => 9, :suit => :hearts, :card => 9]]
    expect(@person.to_s).to eq("David: 18")
  end
end

describe Player do 
  it "is a subclass of Person" do 
    expect(Player.new).to be_a_kind_of(Person)
  end
end

describe Dealer do
  it "is a subclass of Person" do 
    expect(Dealer.new).to be_a_kind_of(Person)
  end
end
