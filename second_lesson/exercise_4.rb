new_hash = {}
num = 1

['a', 'e', 'i', 'o', 'u'].each do |i|
    new_hash[i] = num
    num += 1   
end

puts new_hash