puts "Введите первый коэф"
a = gets.chomp.to_f
puts "Введите второй коэф"
b = gets.chomp.to_f
puts "Введите третий коэф"
c = gets.chomp.to_f

d = (b ** 2) - (4 * a * c)
if d > 0
  puts "Дискриминант: #{d}"
  puts "Первый корень: #{(-b + Math.sqrt(d)) / (2 * a)}"
  puts "Второй корень: #{(-b - Math.sqrt(d)) / (2 * a)}"
elsif d == 0
  puts "Дискриминант: #{d}"
  puts "Корень: #{-b / (2 * a)}"
else
  puts "Дискриминант: #{d}"
  puts "Корней нет"
end
