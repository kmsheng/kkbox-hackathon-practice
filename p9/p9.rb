input = gets.chomp!
numbers = input.split.collect { |s| s.to_i }

str = "#{numbers[0]}+" * numbers[1]
str.chop!

puts eval(str)
