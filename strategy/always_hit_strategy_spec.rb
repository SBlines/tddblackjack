require_relative './always_hit_strategy'

describe AlwaysHitStrategy do
  it "should always hit" do
    @person.cards=[[3,1],[5,4]]
    expect(@person.always_hit?).to be_true
  end



end