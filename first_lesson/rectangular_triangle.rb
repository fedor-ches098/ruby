puts "Введите первiую сторону"
first_side = gets.chomp.to_f
puts "Введите вторую сторону"
second_side = gets.chomp.to_f
puts "Введите третью сторону"
third_side = gets.chomp.to_f

if (first_side > second_side && first_side > third_side) && (first_side ** 2 == (second_side ** 2 + third_side ** 2)) 
  puts "Прямоугольный" 
elsif (second_side > first_side && second_side > third_side) && (second_side ** 2 == (first_side ** 2 + third_side ** 2))
  puts "Прямоугольный"
elsif (third_side > first_side && third_side > second_side) && (third_side ** 2 == (first_side ** 2 + second_side ** 2))
  puts "Прямоугольный"
elsif first_side == second_side && first_side == third_side
  puts "Равносторонний и равнобедренный"
elsif first_side == second_side || first_side == third_side || second_side == third_side
  puts "Равнобедренный"
end
  
