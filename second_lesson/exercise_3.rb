new_array = [1, 1]

while true do 
    sum = new_array[-2] + new_array[-1]
    break if sum >= 100
    new_array << sum
end

puts new_array