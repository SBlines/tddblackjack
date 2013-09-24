require './person'
require './deck'
require './strategy'

Dir["./strategy/*.rb"].each {|file| require file unless file =~ /spec/ }

class Game
  attr_accessor :deck, :player, :dealer, :last_hand, :silent, :shoe_size


  def initialize
    @silent = false
    @shoe_size = 6
    self.deck = create_deck
    self.player = Player.new
    self.player.strategy = Strategy.new(self) 


    self.dealer = Dealer.new("Dealer")
    self.dealer.strategy = DealerStrategy.new(self)

    @last_hand = false
  end

  def create_deck
    new_deck=Array.new
    shoe_size.times do
      new_deck.concat(Deck.new)
    end
    new_deck.shuffle!
  end

  def deal
    @deck = create_deck if @deck.length < 13 * @shoe_size
    @dealer.cards = []
     @player.cards = []
    2.times do
      @player.cards << @deck.pop
      @dealer.cards << @deck.pop
    end 
  end


  # Check for certain game conditions like blackjack (or blackjack push)
  # Otherwise play the player's hand first and then the dealer's hand
  # Check who wins and return either the player/dealer winner (or nil if it's a push)
  def play
    return nil if player.blackjack? && dealer.blackjack?
    return player if player.blackjack?
    return dealer if dealer.blackjack?
    play_hand(player)
    return dealer if player.busted?
    play_hand(dealer)
    return player if dealer.busted?
    case player.total <=> dealer.total
    when 1
      player
    when -1
      dealer
    when 0
      nil
    end
  end

  # given a player (and a player's strategy)
  # play their hand until the strategy says to :stand 
  # or the player busts
  def play_hand(player) 
    while !player.busted? and player.action == :hit
      player.cards<<@deck.pop
    end
  end

end
