puts "Введите Ваше имя"
name = gets.chomp
puts "Введите Ваш рост"
height = gets.to_i
ideal_weight = (height - 110) * 1.15
puts "#{name.capitalize}! Ваш идеальный вес: #{ideal_weight}"
puts "Ваш вес уже оптимальный" if ideal_weight < 0

