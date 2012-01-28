# encoding: utf-8

class Poker

	def initialize(str)

		@largest_cards = []
		@kinds = ["無牌型", "一對", "兩對", "三條", "順子", "同花", "葫蘆", "鐵支", "同花順"]
		@colors = ["梅花", "方塊", "紅心", "黑桃"]
		@cards = make_cards
		@decks = str.split.each_slice(5).to_a

		find_winner
	end

	def find_winner
		values = []

		for deck in @decks

			deck = deck.collect! { |s| s.to_i }
			kind = get_kind(deck)
			values.push(@kinds.index(kind))
			puts " #{ get_deck_msg(deck) } #{ kind }"
		end

		if values[0] > values[1]
			puts "前者大"
		elsif values[0] < values[1]
			puts "後者大"
		else
			# 無牌型比較
			if [] == @largest_cards
				@largest_cards = get_two_largest_cards(@decks)
			end

			first = get_num(@largest_cards[0] - 1)
			second = get_num(@largest_cards[1] - 1)

			if first > second
				puts "前者大"
			elsif first < second
				puts "後者大"
			elsif first == second

				first_color = get_color(@largest_cards[0] - 1)
				second_color = get_color(@largest_cards[1] - 1)
				first_index = @colors.index(first_color)
				second_index = @colors.index(second_color)

				if (first_color > second_color)
					puts "前者大"
				elsif (first_color < second_color)
					puts "後者大"
				end

			end
		end

	end

	def get_two_largest_cards(decks)

		largest_cards = []
		for deck in decks
			deck.sort!
			largest_cards.push(deck.pop)
		end

		return largest_cards
	end

	def get_kind(cards)

		kind = ""
		flush = is_flush(cards)
		straight = is_straight(cards)

		if flush && straight
			kind = "同花順"
		elsif is_four(cards)
			kind = "鐵支"
		elsif is_full_house(cards)
			kind = "葫蘆"
		elsif is_flush(cards)
			kind = "同花"
		elsif straight
			kind = "順子"
		elsif is_three(cards)
			kind = "三條"
		elsif is_two_pairs(cards)
			kind = "兩對"
		elsif is_pair(cards)
			kind = "一對"
		else
			kind = "無牌型"
		end

		return kind

	end

	# 索引轉數字
	def index_to_numbers(cards)

		numbers = []
		for index in cards
			numbers.push({ :index => index, :value => @cards[index]["num"] })
		end

		return numbers.sort_by { |v| v[:value] }
	end

	# 索引轉花色
	def index_to_colors(cards)

		colors = []
		for index in cards
			colors.push({ :index => index, :value => @cards[index]["color"] })
		end

		return colors.sort_by { |v| v[:value] }
	end

	# 鐵支
	def is_four(cards)

		numbers = index_to_numbers(cards)

		for i in 0..1
			if numbers[i][:value] == numbers[i + 1][:value] && numbers[i + 1][:value] == numbers[i + 2][:value] && numbers[i + 2][:value] == numbers[i + 3][:value]
				@largest_cards.push(numbers[i][:index])
				return true
			end
		end

		return false
	end

	#葫蘆
	def is_full_house(cards)

		numbers = index_to_numbers(cards)

		if ((numbers[0][:value] == numbers[1][:value] && numbers[1][:value] == numbers[2][:value] && numbers[3][:value] == numbers[4][:value]) or
		(numbers[0][:value] == numbers[1][:value] && numbers[2][:value] == numbers[3][:value] && numbers[3][:value] == numbers[4][:value]))
			@largest_cards.push(numbers[i][:index])
			return true
		end

		return false
	end

	# 同花
	def is_flush(cards)

		colors = index_to_colors(cards)

		if colors[0][:value] == colors[1][:value] && colors[1][:value] == colors[2][:value] && colors[2][:value] == colors[3][:value] && colors[3][:value] == colors[4][:value]
			@largest_cards.push(colors[4][:index])
			return true
		end

		return false
	end

	# 順子
	def is_straight(cards)

		numbers = index_to_numbers(cards)

		if numbers[0][:value] + 1 == numbers[1][:value] && numbers[1][:value] + 1 == numbers[2][:value] && numbers[2][:value] + 1 == numbers[3][:value] && numbers[3][:value] + 1 == numbers[4][:value]
			@largest_cards.push(numbers[i][:index])
			return true
		end

		return false
	end

	# 三條
	def is_three(cards)

		numbers = index_to_numbers(cards)

		for i in 0..2
			if numbers[i][:value] == numbers[i + 1][:value] && numbers[i + 1][:value] == numbers[i + 2][:value]
				@largest_cards.push(numbers[i][:index])
				return true
			end
		end

		return false
	end

	def count_pairs(cards)

		numbers = index_to_numbers(cards)
		count = 0
		largest_card = 0

		for i in 0..3
			if numbers[i][:value] == numbers[i + 1][:value]
				if numbers[i][:index] > largest_card
					largest_card = numbers[i][:index]
				end
				count += 1
			end
		end

		return { :count => count, :largest_card => largest_card }

	end

	# 兩對
	def is_two_pairs(cards)

		count = count_pairs(cards)

		if 2 == count[:count]
			@largest_cards.push(count[:largest_card])
			return true
		end

		return false
	end

	# 一對
	def is_pair(cards)

		count = count_pairs(cards)

		if 1 == count[:count]
			@largest_cards.push(count[:largest_card])
			return true
		end

		return false
	end

	def get_deck_msg(deck)
		msg = ""
		for i in deck
			index = i - 1
			msg += "#{i}(#{ @cards[index]["color"] } #{ get_num(index, true) }) "
		end

		return msg
	end

	def make_cards

		cards = []
		0.upto(51) { |i| cards[i] = { "color" => get_color(i), "num" => get_num(i) } }
		return cards
	end

	def get_color(index)
		index /= 13
		return @colors[index]
	end

	def get_num(index, display_jqka = false)

		@special_num = {11 => "J", 12 => "Q", 13 => "K", 14 => "A"}
		index = index % 13 + 1

		if (1 == index)
			index = 14
		end

		if ((display_jqka) && (nil != @special_num[index]))
			index = @special_num[index]
		end

		return index
	end

end

while (str = gets)
	p = Poker.new(str.chomp!)
end
