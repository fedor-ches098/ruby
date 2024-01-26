puts "Введите день"
day = gets.to_i
puts "Введите месяц"
month = gets.to_i
puts "Введите год"
year = gets.to_i

months_hash = {
    1 => 31, 
    2 => ((year % 4 == 0 && year % 100 != 0 || year % 400 == 0) ? 29 : 28),
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31
}

result = 0
months_hash.each do |m, d|
    break if month == 1
    month -= 1
    result = result + months_hash[month]
end

puts "Порядковый номер: #{result + day}"

