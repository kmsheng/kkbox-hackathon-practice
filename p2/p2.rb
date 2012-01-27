class PI

	def initialize
		@count = 0
	end

	def set_times(times)
		@times = times
	end

	def drop_points()

		for i in 0..@times - 1
			if (is_inside(get_random_float, get_random_float))
				@count += 1
			end
		end

	end

	def get_pie
		@count / @times.to_f * 4
	end

	def get_random_float()
		Random.rand(@times) / @times.to_f
	end

	def is_inside(x, y)
		distance = Math.sqrt((x ** 2) + (y ** 2))
		return distance <= 1
	end

end

pi = PI.new

n = gets.chomp!.to_i
pi.set_times n
pi.drop_points
p pi.get_pie
