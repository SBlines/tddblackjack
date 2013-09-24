class ThresholdStrategy < Strategy
  def initialize(player, cutoff = 17)
  	super(player)
  	@cutoff = cutoff
  end
  def action
   if @player.total <= @cutoff
      :hit
    else
      :stand
    end
  end
end
