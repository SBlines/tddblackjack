#this is a naive strategy that should not be used in a casino
class Strategy
    def initialize(data)
        @player = data.player if data.kind_of?(Game)
        @player = data if data.kind_of?(Person)
    end
   
    def action
        raise "Need to use as subclass"
    end
end