module TrainActions
  def create_train
    number = ask('Введите номер поезда:')
    type = ask('Введите тип поезда')
    trains << self.class::TRAIN_CLASS[type.to_sym].new(number, type.to_sym)
    puts 'Поезд создан'
  rescue StandardError
    puts 'Неправильные данные. Еще раз'
    retry
  end

  def add_route
    route = get_by_choice('маршрута', routes, :stations)
    train = get_by_choice('поезда', trains, :number)
    train.add_route(route)
    puts "Текущая станция: #{train.current_station.name}"
  end

  def add_wagon
    train = get_by_choice('поезда', trains, :number)
    if train.type == :cargo
      volume = ask('Введите объем:').to_i
      train.add_wagon(CargoWagon.new(volume))
    elsif train.type == :passenger
      seats = ask('Введите количество мест:').to_i
      train.add_wagon(PassengerWagon.new(seats))
    end
  end

  def show_wagons
    train = get_by_choice('поезда', trains, :number)
    train.wagon_block do |wagon|
      puts "Занято мест: #{wagon.used_place}, Свободно мест: #{wagon.free_place}" if wagon.type == :passenger
      puts "Занято объема: #{wagon.used_place}, Свободно объема: #{wagon.free_place}" if wagon.type == :cargo
    end
  end

  def load_wagon
    train = get_by_choice('поезда', trains, :number)

    wagon = get_by_choice('вагона', train.wagons, :type)

    if wagon.type == :cargo
      volume = ask('Введите объем').to_i
      wagon.take_place(volume)
    elsif wagon.type == :passenger
      wagon.take_place
    end
  end

  def remove_wagon
    train = get_by_choice('поезда', trains, :number)
    train.remove_wagon
    puts "Количество вагонов поезда: #{train.wagons.count}"
  end

  def go_station
    train = get_by_choice('поезда', trains, :number)
    input1 = ask('Введите направление: (forward/back)')
    raise if train.route.nil?

    if input1 == 'back'
      train.go_previous_station
      puts "Станция: #{train.current_station.name}"
    elsif input1 == 'forward'
      train.go_next_station
      puts "Станция: #{train.current_station.name}"
    end
  end
end
