class Sudoku

	def initialize(width)

		@width = width
		@sqrt_width = Math.sqrt(width).to_i
		@order = (0..@sqrt_width - 1).to_a
		@numbers = (1..@width).to_a.shuffle

		make_first_template
		make_board
	end

	def shift_order
		element = @order.shift
		@order.push(element)
	end

	def make_board

		@board = []

		for i in 0..@width - 1
			@board[i] = (0..@width - 1).to_a
		end

	end

	def make_first_template

		@template = []

		for i in 0..@sqrt_width - 1
			@template[i] = []
			for j in 0..@sqrt_width - 1
				@template[i][j] = @numbers.shift
			end
		end

	end

	def shift_row(index)
		element = @template[index].shift
		@template[index].push(element)
	end

	def get_answer

		for k in 0..@sqrt_width - 1
			for i in 0..@sqrt_width - 1
				for j in 0..@sqrt_width - 1
					stick_row(i, j, k)
				end
				shift_row(k)
			end

			shift_order
		end

	end

	def stick_row(i, j, k)

		start = j * @sqrt_width
		stop = start + @sqrt_width - 1
		row = @order[j] + i * @sqrt_width
		num = 0

		for index in start..stop
			@board[row][index] = @template[k][num]
			num += 1
		end

	end

	def get_board_graph

		str = ""

		for i in 0..@width - 1
			for j in 0..@width - 1
				str += "#{ @board[i][j] }  "

				if (0 == (j + 1) % @sqrt_width)
					str += "     "
				end
			end

			if (0 == (i + 1) % @sqrt_width)
				str += "\n\n"
			end
			str += "\n\n"
		end

		return str

	end

end

s = Sudoku.new( gets.chomp!.to_i )
s.get_answer
puts s.get_board_graph
