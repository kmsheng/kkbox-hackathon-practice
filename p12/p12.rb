# encoding: utf-8
class Billards

	def initialize()
		@points = []
		@max = 36
	end

	def get_coords(str)
		points = str.split(/[\s,]/)
		_x = 0
		_y = 1

		0.upto(1) { |i|  @points[i] = { :x => points[_x + i * 2].to_i ,:y => points[_y + i * 2].to_i } }
	end

	def is_touched
		distance = Math.sqrt (@points[0][:x] - @points[1][:x]) ** 2 + (@points[0][:y] - @points[1][:y]) ** 2

		if distance <= 36
			puts "碰撞"
		else
			puts "沒碰撞"
		end
	end
end

b = Billards.new

while input = gets
	b.get_coords(input.chomp!)
	b.is_touched
end
