require_relative "station"
require_relative "route"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "cargo_wagon"
require_relative "passenger_wagon"
require_relative "ui"

class Controller
  attr_accessor :station, :route, :train, :wagon

  def initialize
    @station = nil
    @route   = nil
    @train   = nil
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
      station_created? ? create_train : (puts "Станция не создана")
    when 3
      create_route
    when 4
      route_created? ? add_station : (puts "Маршрут не создан")
    when 5
      route_created? ? remove_station : (puts "Маршрут не создан")
    when 6
      (route_created? && train_created?) ? add_route : (puts "Маршрут и поезд не созданы")
    when 7
      train_created? ? add_wagon : (puts "Поезд не создан")
    when 8
      (train_created? && wagons_exists?) ? remove_wagon : (puts "Поезд и вагоны не созданы")
    when 9
      (train_created? && route_created?) ? go_next_station : (puts "Поезд и маршрут не созданы")
    when 10
      (train_created? && route_created?) ? go_previous_station : (puts "Поезд и маршрут не созданы")
    when 11
      route_created? ? show_stations : (puts "Маршрут не создан")
    when 12
      (station_created? && train_created?) ? show_trains : (puts "Станция и поезд не созданы")
    when 13
      exit
    end
  end

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
    self.station = Station.new(name)
    puts "Станция создана"
  end

  def create_train
    puts "Введите номер поезда:"
    number = gets.chomp.to_i
    puts "Введите тип поезда:"
    type = gets.chomp 
    self.train = TRAIN_TYPE[type.to_sym][:type].new(number, type, TRAIN_TYPE[type.to_sym][:wagon_type])
    add_train
    puts "Создан поезд"
  end

  def create_route
    puts "Введите исходную и конечную станции:"
    from = gets.chomp
    to = gets.chomp
    self.route = Route.new(from, to)
    puts "Создан маршрут: #{self.route.stations}"
  end

  def add_station
    puts "Введите станцию:"
    station = gets.chomp
    self.route.add_station(station)
    puts "Станции: #{self.route.stations}"
  end

  def remove_station
    puts "Введите станцию:"
    station = gets.chomp
    unless (station == self.route.stations[0]) || (station == self.route.stations[-1])
      self.route.remove_station(station)
    end
    puts "Станции: #{self.route.stations}"
  end

  def add_route
    self.train.add_route(route)
    puts "Маршрут добавлен к поезду. Текущая станция: #{self.train.current_station}"
  end

  def add_wagon
    wagon_type = self.train.wagon_type
    puts "Добавление вагона типа #{self.train.type}"
    self.wagon = Kernel.const_get(wagon_type).new
    self.train.add_wagon(self.wagon)
    puts "Количество вагонов поезда: #{self.train.wagons.count}"
  end

  def remove_wagon
    puts "Удаление вагона"
    self.train.remove_wagon
    puts "Количество вагонов поезда: #{self.train.wagons.count}"
  end

  def go_next_station
    puts "Перемещение поезда вперед"
    self.train.go_next_station
  end

  def go_previous_station
    puts "Перемещение поезда назад"
    self.train.go_previous_station
  end

  def show_stations
    puts "Список станций: #{self.route.stations}"
  end

  def show_trains
    puts "Список поездов: #{self.station.trains.count}"
  end

  private 
  # вспомогательные методы

  def add_train
    self.station.add_train(self.train)
  end

  def route_created?
    self.route.nil? ? false : true
  end

  def train_created?
    self.train.nil? ? false : true
  end

  def wagons_exists?
    self.train.wagons.empty? ? false : true
  end

  def station_created?
    self.station.nil? ? false : true
  end
end

run = Controller.new.start