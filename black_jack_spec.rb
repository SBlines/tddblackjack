require './black_jack'
require './person'

describe "Game" do

  # before each test, create a new @game
  before(:each) do
    @game = Game.new()
  end

  it "has an attribute called shoe_size of 6" do
    
    expect(@game.shoe_size).to eq(6)
  end

  it 'generates a deck of of shoe_size * 52 when initialized' do
    expect(@game.deck.length).to eq(@game.shoe_size * 52)
  end

  it "creates a shuffled deck" do
    expect(@game.deck).not_to eq(Deck.new * @game.shoe_size)
  end

  it 'has two players' do
    expect(@game.player).to be_a_kind_of Person
    expect(@game.dealer).to be_a_kind_of Person
  end

  
  it 'deals two cards to the player' do
    @game.deal
    expect(@game.player.cards.length).to eq(2)
  end
  it 'deals two cards to the dealer' do
    @game.deal
    expect(@game.dealer.cards.length).to eq(2)
  end

  describe "while dealing" do
    it "creates a new deck if there are less than 1/4 of the cards remaining" do 
      @game.deck = @game.deck[0...(0.24)*52*@game.shoe_size]
      @game.deal
      expect(@game.deck.length).to  be >= (0.25)*52*@game.shoe_size 
    end

    it "gives the player two cards from the deck" do 
      @game.deal
    expect(@game.player.cards.length).to eq(2)
    end

    it "gives the dealer two cards from the deck" do
      @game.deal
    expect(@game.dealer.cards.length).to eq(2)
    end
  end

  describe "while playing" do
    it "returns nil if the player and dealer both have blackjack" do 
      @game.player.cards=[Deck::Card[:value => 11, :suit => :diamonds, :card => "ace"],
    Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      @game.dealer.cards=[Deck::Card[:value => 11, :suit => :diamonds, :card => "ace"],
    Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      expect(@game.play).to be(nil)
    end

    it "returns the player object as the winner if the player has blackjack" do
      @game.player.cards=[Deck::Card[:value => 11, :suit => :diamonds, :card => "ace"],
        Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      @game.dealer.cards=[Deck::Card[:value => 11, :suit => :hearts, :card => "ace"],
        Deck::Card[:value => 9, :suit => :hearts, :card => 9]]
      expect(@game.play).to eq(@game.player)
    end


    it "returns the dealer object as the winner if the dealer has blackjack" do 
      @game.dealer.cards=[Deck::Card[:value => 11, :suit => :diamonds, :card => "ace"],
        Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      @game.player.cards=[Deck::Card[:value => 11, :suit => :hearts, :card => "ace"],
        Deck::Card[:value => 9, :suit => :hearts, :card => 9]]
      expect(@game.play).to eq(@game.dealer)

    end

    it "should return the dealer if the player busts" do
        @game.player.strategy = AlwaysStandStrategy.new(@game)
      @game.dealer.cards=[Deck::Card[:value => 9, :suit => :diamonds, :card => 9],
        Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      @game.player.cards=[Deck::Card[:value => 8, :suit => :diamonds, :card => 8],
        Deck::Card[:value => 7, :suit => :hearts, :card => 7],
        Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
        expect(@game.play).to eq(@game.dealer)
    end

    it "should return the player if the dealer busts" do 
      @game.dealer.strategy = AlwaysHitStrategy.new(@game.dealer)
      @game.player.strategy = AlwaysStandStrategy.new(@game)
      @game.dealer.cards=[Deck::Card[:value => 9, :suit => :diamonds, :card => 9],
        Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      @game.player.cards=[Deck::Card[:value => 8, :suit => :diamonds, :card => 8],
        Deck::Card[:value => 7, :suit => :hearts, :card => 7]]
        expect(@game.play).to eq(@game.player)

    end

    it "should return the player if the dealer's total is < the player's total" do
      @game.player.strategy = AlwaysStandStrategy.new(@game)
      @game.dealer.cards=[Deck::Card[:value => 9, :suit => :diamonds, :card => 9],
        Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      @game.player.cards=[Deck::Card[:value => 10, :suit => :hearts, :card => "king"],
        Deck::Card[:value => 10, :suit => :hearts, :card => "queen"]]
      expect(@game.play).to eq(@game.player)
    end

    it "returns the dealer if the player's total is < the dealer's total" do
      @game.player.strategy = AlwaysStandStrategy.new(@game)
      @game.player.cards=[Deck::Card[:value => 9, :suit => :diamonds, :card => 9],
        Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      @game.dealer.cards=[Deck::Card[:value => 10, :suit => :hearts, :card => "king"],
        Deck::Card[:value => 10, :suit => :hearts, :card => "queen"]]
      expect(@game.play).to eq(@game.dealer)
    end

    it "should return nil if the player and the dealer have the same total" do
            @game.player.strategy = AlwaysStandStrategy.new(@game)
      @game.dealer.cards=[Deck::Card[:value => 9, :suit => :diamonds, :card => 9],
        Deck::Card[:value => 10, :suit => :hearts, :card => "jack"]]
      @game.player.cards=[Deck::Card[:value => 9, :suit => :hearts, :card => 9],
        Deck::Card[:value => 10, :suit => :hearts, :card => "queen"]]
      expect(@game.play).to eq(nil)
    end
  end

  describe "while playing on Person's hand" do
    it "should obey the player's strategy" do 
      @game.player.strategy = AlwaysHitStrategy.new(@game)
      @game.play_hand(@game.player)
      expect(@game.player.busted?).to be_true
    end

    it "should only add cards to the player's hand until the player says stand or busts" do
      @game.player.strategy = AlwaysStandStrategy.new(@game)
      @game.deal
      @game.play
      expect(@game.player.cards.length).to eq(2)

    end
  end
end

