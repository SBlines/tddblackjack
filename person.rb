require './strategy'
require './deck'

class Person
	attr_accessor :name, :strategy, :cards
	def initialize(name ="")
		@name=name
		@cards = []
	end
	def total
		var=0
		@cards.each do |car|
			car[:value] = 11 if car[:card] == "ace"
			var+=card_val(car)
		end
		aces = @cards.select { |c| c[:value] == 11}
		while (var > 21 && aces.length > 0) do
			var -= 10
			aces.last[:value] = 1
			aces.pop
		end
		return var
	end

	def card_val(a)
		a[:value]
	end
	def blackjack?
		cards.length == 2 and total == 21
	end
	def busted?
		total > 21
	end
	def to_s
		return "#{name}: #{total}"
	end
	def action
		@strategy.action
	end

end

class Player < Person
end

class Dealer < Person
end