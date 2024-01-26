purchases = {}

while true do 
    puts "Введите название товара"
    name = gets.chomp
    break if name == "стоп"
    puts "Введите цену товара"
    coast = gets.chomp.to_f
    puts "Введите количество товара"
    quantity = gets.chomp.to_f
    
    purchases[name] = {"coast" => coast, "quantity" => quantity}
    puts "Покупки: #{purchases}"
    puts "Сумма для #{name}: #{purchases[name]["coast"] * purchases[name]["quantity"]}"
end

result = 0
purchases.each do |product, info|
    result += (purchases[product]["coast"] * purchases[product]["quantity"])
end
puts "Итоговая сумма: #{result}"
