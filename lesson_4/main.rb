require_relative "station"
require_relative "route"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "cargo_wagon"
require_relative "passenger_wagon"
require_relative "ui"

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
    menu #вызываем меню действий
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
  TRAIN_TYPE = {
    cargo:     {
      type: CargoTrain,
      wagon_type: CargoWagon
    },
    passenger: {
      type: PassengerTrain,
      wagon_type: PassengerWagon
    }
  }

  def create_station
    puts "Введите имя станции:"
    name = gets.chomp
    self.stations << Station.new(name)
    puts "Станция создана"
  end

  def create_train
    puts "Введите номер поезда:"
    number = gets.chomp.to_i
    puts "Введите тип поезда:"
    type = gets.chomp 
    self.trains << TRAIN_TYPE[type.to_sym][:type].new(number, type, TRAIN_TYPE[type.to_sym][:wagon_type]) 
    puts "Поезд создан"
  end

  def create_route
    puts "Введите исходную и конечную станции:"
    from = gets.chomp
    to = gets.chomp
    self.routes << Route.new(from, to)
    puts "Маршрут создан"
  end

  def add_station
    route = get_route_by_choice
    puts "Введите станцию:"
    station = gets.chomp
    route.nil? ? (puts "Маршрут не создан") : route.add_station(station)
    puts "Станции: #{route.stations}" unless route.nil?
  end

  def remove_station
    route = get_route_by_choice
    puts "Введите станцию:"
    station = gets.chomp
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
    route = get_route_by_choice
    train = get_train_by_choice
    if (train.nil?) || (route.nil?)
      puts "Поезд или маршрут не созданы"
    else 
      train.add_route(route)
      puts "Маршрут добавлен к поезду. Текущая станция: #{train.current_station}" 
    end
  end

  def add_wagon
    train = get_train_by_choice
    self.wagon = train.wagon_type.new
    train.nil? ? (puts "Поезд не создан") : train.add_wagon(self.wagon)
    puts train.wagons
    puts "Количество вагонов поезда: #{train.wagons.count}" unless train.nil?
  end

  def remove_wagon
    train = get_train_by_choice
    if train.nil?
      puts "Поезд не создан"
    else
      train.wagons.empty? ? (puts "В поезде нет вагонов") : train.remove_wagon
      puts "Количество вагонов поезда: #{train.wagons.count}"
    end
  end

  def go_next_station
    train = get_train_by_choice
    train.nil? ? (puts "Поезд не создан") : train.go_next_station
    puts "Поезд перемещен вперед" unless train.nil?
  end

  def go_previous_station
    train = get_train_by_choice
    train.nil? ? (puts "Поезд не создан") : train.go_previous_station
    puts "Поезд перемещен назад" unless train.nil?
  end

  def show_stations
    puts "Список станций: #{self.stations.map {|station| station.name}}"
  end

  def show_trains
    station = get_station_by_choice
    station.nil? ? (puts "Станция не создана") : (puts "Список поездов: #{station.trains.count}")
  end

  def add_train
    train = get_train_by_choice
    station = get_station_by_choice
    if (station.nil?) || (train.nil?)
      puts "Поезд или станция не созданы"
    else  
      station.add_train(train)
      puts "Поезд добален на станцию"
    end
  end

  def get_route_by_choice
    puts "Введите номер маршрута:"
    self.routes.each_with_index {|r,n| puts "#{n} #{r.stations}"}
    index = gets.chomp.to_i
    return self.routes[index]
  end

  def get_train_by_choice
    puts "Введите номер поезда:"
    self.trains.each_with_index {|t,n| puts "#{n} #{t.number}"}
    index = gets.chomp.to_i
    return self.trains[index]
  end

  def get_station_by_choice
    puts "Введите номер станции:"
    self.stations.each_with_index {|s,n| puts "#{n} #{s.name}"}
    index = gets.chomp.to_i
    return self.stations[index]
  end
end

run = Controller.new.start