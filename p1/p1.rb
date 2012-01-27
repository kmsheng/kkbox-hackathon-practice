# encoding: utf-8
class Packing

	def initialize
		@packs = []
		@rest = []
	end

	def set_items(input)
		@items = to_int_array( input.split ).sort.reverse
		@rest = @items.clone
	end

	def to_int_array(str_array)
		str_array.collect{ |s| s.to_i }
	end

	def pack(box_size)

		for index in 0..@items.size - 1

			if ( !@rest.include?@items[index] )
				next
			end

			@packs[index] = []
			@packs[index].push( @items[index] )
			@rest.delete_at @rest.index(@items[index])

			if (@items[index] != box_size)
				size = box_size - @items[index]

				@packs[index] = stick_items(size, @packs[index])
			end

		end

		return @packs
	end

	def stick_items(size, box)

		for item in @rest

			if (0 == size)
				break
			end

			if (item <= size)
				box.push(item)
				@rest.delete_at @rest.index(item)
				size -= item
			end

		end

		return box
	end

end

p = Packing.new

while (input = gets)
	p.set_items input.chomp!
	p p.pack 10
end
