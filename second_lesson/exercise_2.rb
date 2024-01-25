new_array = []
(10..100).each do |num|
    new_array << num if num % 5 == 0
end
p new_array