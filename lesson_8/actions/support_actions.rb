module SupportActions
  def ask(message)
    puts message
    gets.chomp
  end

  def get_by_choice(title, items, symbol)
    puts "Введите номер #{title}:"
    items.each_with_index { |i, n| puts "#{n} #{i.send(symbol)}" }

    index = gets.chomp.to_i
    raise 'Объект не найден' if items[index].nil?

    items[index]
  end
end
