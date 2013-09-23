require './strategy'

class Person
	attr_accessor :name, :strategy, :cards
	def initialize(name ="")
		@name=name
		@cards = []
	end
	def total
		var=0
		@cards.each do |car|
			var+=card_val(car)
		end
		ace_count = @cards.select { |c| c[0] == 1}.length
		while (var > 21 && ace_count > 0) do
			var -= 10
			ace_count -= 1
		end
		return var
	end

	def card_val(a)
		if a[0] ==1
			return 11
		elsif a[0] <= 10
			return a[0]
		else
			return 10
		end
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

end

class Player < Person
end

class Dealer < Person
end