require_relative "station"
require_relative "route"
require_relative "train"
require_relative "wagon"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "cargo_wagon"
require_relative "passenger_wagon"

class Controller
  attr_accessor :stations, :routes, :trains, :wagon

  def initialize
    @stations = []
    @routes   = []
    @trains   = []
    @wagon   = nil
  end

  def start
    while true
      run
    end
  end

  def run
    menu(MENU)
    number = gets.chomp.to_i
    case number
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      add_train
    when 5
      add_station
    when 6
      remove_station
    when 7
      add_route
    when 8
      add_wagon
    when 9
      remove_wagon
    when 10
      go_next_station
    when 11
      go_previous_station
    when 12
      show_stations
    when 13
      show_trains
    when 14
      exit
    end
  end

  private 
  # думаю что эти методы не должны быть вне класса
  MENU = [
    "Создать станцию",
    "Создать поезд",  
    "Создать маршрут", 
    "Добавить поезд на станцию", 
    "Добавить станцию в маршрут", 
    "Удалить станцию из маршрута", 
    "Назначить маршрут поезду", 
    "Добавить вагон к поезду", 
    "Отцепить вагон от поезда", 
    "Переместить поезд по маршруту вперед", 
    "Переместить поезд по маршруту назад", 
    "Просмотреть список станций", 
    "Просмотреть список поездов на станции", 
    "Выход"
  ]

  def menu(menu)
    menu.each_with_index {|i,n| puts "#{n + 1} #{i}"}
  end

  def ask(message)
    puts "#{message}"
    return gets.chomp
  end

  def create_station
    name = ask("Введите имя станции:")
    self.stations << Station.new(name)
    puts "Станция создана"
  end

  def create_train
    number = ask("Введите номер поезда:")
    type = ask("Введите тип поезда:") 
    create_train_by_type(number, type) 
    puts "Поезд создан"
  end

  def create_train_by_type(number, type)
    if type.to_sym == :cargo   
      self.trains << CargoTrain.new(number, type.to_sym)
    elsif type.to_sym == :passenger
      self.trains << PassengerTrain.new(number, type.to_sym)
    end
  end

  def create_route
    from = ask("Введите исходную станцию:")
    to = ask("Введите конечную станцию:")
    self.routes << Route.new(from, to)
    puts "Маршрут создан"
  end

  def add_station
    route = get_by_choice("маршрута", routes, :stations)
    station = ask("Введите станцию:")
    route.nil? ? (puts "Маршрут не создан") : route.add_station(station)
    puts "Станции: #{route.stations}" unless route.nil?
  end

  def remove_station
    route = get_by_choice("маршрута", routes, :stations)
    station = ask("Введите станцию:")
    unless route.nil?
      unless (station == route.stations[0]) || (station == route.stations[-1])
        route.remove_station(station)
      end
      puts "Станции: #{route.stations}"
    else  
      puts "Маршрут не создан"
    end
  end

  def add_route
    route = get_by_choice("маршрута", routes, :stations)
    train = get_by_choice("поезда", trains, :number)
    if (train.nil?) || (route.nil?)
      puts "Поезд или маршрут не созданы"
    else 
      train.add_route(route)
      puts "Маршрут добавлен к поезду. Текущая станция: #{train.current_station}" 
    end
  end

  def add_wagon
    train = get_by_choice("поезда", trains, :number)
    return (puts "Поезд не создан") if train.nil?
    if train.type == :cargo
      train.add_wagon(CargoWagon.new)
    elsif train.type == :passenger
      train.add_wagon(PassengerWagon.new)
    end
    puts "Количество вагонов поезда: #{train.wagons.count}"
  end

  def remove_wagon
    train = get_by_choice("поезда", trains, :number)
    if train.nil?
      puts "Поезд не создан"
    else
      train.wagons.empty? ? (puts "В поезде нет вагонов") : train.remove_wagon
      puts "Количество вагонов поезда: #{train.wagons.count}"
    end
  end

  def go_next_station
    train = get_by_choice("поезда", trains, :number)
    if (train.nil?) || (train.route.nil?)
      puts "Поезд не создан или не имеет маршрута"
    else 
      train.go_next_station
      puts "Поезд перемещен вперед. Текущая станция: #{train.current_station}"
    end
  end

  def go_previous_station
    train = get_by_choice("поезда", trains, :number)
    if (train.nil?) || (train.route.nil?)
      puts "Поезд не создан или не имеет маршрута"
    else 
      train.go_previous_station
      puts "Поезд перемещен назад. Текущая станция: #{train.current_station}"
    end
  end

  def show_stations
    if stations.empty?
      puts "Станции не созданы"
    else
      puts "Список станций: #{stations.map {|station| station.name}}"
    end 
  end

  def show_trains
    station = get_by_choice("станции", stations, :name)
    station.nil? ? (puts "Станция не создана") : (puts "Список поездов: #{station.trains.count}")
  end

  def add_train
    train = get_by_choice("поезда", trains, :number)
    station = get_by_choice("станции", stations, :name)
    if (station.nil?) || (train.nil?)
      puts "Поезд или станция не созданы"
    else  
      station.add_train(train)
      puts "Поезд добален на станцию"
    end
  end

  def get_by_choice(title, items, symbol)
    puts "Введите номер #{title}:"
    items.each_with_index {|i,n| puts "#{n} #{i.send(symbol)}"}
    index = gets.chomp.to_i
    return items[index]
  end
end

run = Controller.new.start