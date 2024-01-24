puts "Введите первую сторону"
first_side = gets.to_i
puts "Введите вторую сторону"
second_side = gets.to_i
puts "Введите третью сторону"
third_side = gets.to_i

# Находим гипотенузу
hypotenuse = nil
leg_1 = nil
leg_2 = nil
if first_side > second_side && first_side > third_side
  hypotenuse = first_side
  leg_1 = second_side
  leg_2 = third_side
elsif second_side > first_side && second_side > third_side
  hypotenuse = second_side
  leg_1 = first_side
  leg_2 = third_side
else
  hypotenuse = third_side
  leg_1 = first_side
  leg_2 = second_side
end

# Определяем прямоугольный треугольник 
if hypotenuse ** 2 == (leg_1 ** 2) + (leg_2 ** 2)
 puts "Прямоугольный"
elsif hypotenuse == leg_1 && hypotenuse == leg_2
  puts "Равносторонний и равнобедренный"
elsif hypotenuse == leg_1 || hypotenuse == leg_2 || leg_1 == leg_2
  puts "Равнобедренный"
end
  
