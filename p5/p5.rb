# encoding: utf-8
while input = gets
	numbers = input.chomp!.split.collect { |s| s.to_i }
	m = numbers[0]
	n = numbers[1]
	s = m * n

	while 0 != n
		r = m % n
		m = n
		n = r
	end

	puts "#{m} #{s / m}"
end
