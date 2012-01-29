# encoding: utf-8
# @author Kuan Min Sheng
class Window

	# Initialize for @windows and @clicks array
	def initialize
		@windows = []
		@clicks = []
	end

	# Get the coordinates of window
	#
	# @param [String] a string that represents the coordinates separated by space. e.g. "0 0 10 10"
	def get_window_coords(str)
		@windows.push(to_int_array(str))
	end

	# Get the coodinates which user clicks.
	#
	# @param [String] a string that represents the coordinate separated by space. e.g. "1 1"
	def get_click_coords(str)
		@clicks.push(to_int_array(str))
	end


	# Find out which number of window is clicked
	#
	# @return [Integer] the number of window and -1 means the user does not click anything
	def find_window

		@which = []

		index_of_click = 0
		for click in @clicks

			index_of_window = 0
			clicked = -1
			for window in @windows
				# check if the coord is inside the area of window
				if click[0] <= window[2] and click[0] >= window[0] and click[1] <= window[3] and click[1] >= window[1]
					clicked = index_of_window
				end
				index_of_window += 1
			end

			@which.push(clicked)
			index_of_click += 1
		end

		return @which

	end

	# Convert a string to integer array
	#
	# @param [String] the string to be conveted. e.g. "0 0 1 2"
	# @return [Array<Integer>] the integer array
	def to_int_array(str)
		str.split.collect { |s| s.to_i }
	end

end

w = Window.new

# Get the quantity of window
number = gets.to_i
1.upto(number) { w.get_window_coords(gets) }

# Get how many the mouse clicks
click = gets.to_i
1.upto(click) { w.get_click_coords(gets) }

puts w.find_window
