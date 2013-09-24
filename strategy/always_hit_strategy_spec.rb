require_relative './always_hit_strategy'

describe AlwaysHitStrategy do
  it "should always hit" do
  	@person = Person.new("Idiot")
  	@person.strategy = AlwaysHitStrategy.new(@person)
    @person.cards=[Deck::Card[:value => 11, :suit => :hearts, :card => "ace"],
        Deck::Card[:value => 9, :suit => :hearts, :card => 9]]
    expect(@person.action).to eq(:hit)
  end



end