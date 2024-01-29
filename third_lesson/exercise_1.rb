class Station
  attr_accessor :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    trains.select {|train| train.type == type}.size
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_accessor :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def show_stations
    puts stations
  end
end

class Train
  attr_accessor :speed, :car_count, :route
  attr_reader   :number, :type
  
  def initialize(number, type, car_count)
    @number = number
    @type = type
    @speed = 0
    @car_count = car_count
  end

  def stop
    @speed = 0
  end

  def remove_car
    @car_count -= 1 if @speed == 0
  end

  def add_car
    @car_count += 1 if @speed == 0
  end

  def take_route(route)
    self.route = route
    @current_station_index = 0

    current_station
  end

  def go_next_station
    @current_station_index += 1 if next_station
  end

  def go_previous_station
    @current_station_index -= 1 if previous_station
  end 

  def current_station
    route.stations[@current_station_index] unless route.nil?
  end

  def next_station
    route.stations[@current_station_index + 1] unless route.nil?
  end

  def previous_station
    route.stations[@current_station_index - 1] unless route.nil?
  end 
end

puts "-----------------------------------------"
route = Route.new("Pavshino", "Dmitrovskaya")
route.add_station("Tyshinskaya")
route.add_station("Shukinskaya")
route.remove_station("Shukinskaya")
route.show_stations
puts "-----------------------------------------"
train_1 = Train.new("1490", "cargo", 20)
train_2 = Train.new("1500", "passenger", 10)
train_3 = Train.new("1495", "cargo", 15)
train_1.take_route(route)
puts train_1.current_station
train_1.go_next_station
train_1.go_next_station
train_1.go_previous_station
puts train_1.previous_station
puts train_1.current_station
puts train_1.next_station
train_2.go_next_station
puts train_2.current_station
train_2.speed = 120
train_2.add_car
puts train_2.car_count
train_3.add_car
puts train_3.car_count
puts "-----------------------------------------"
station_1 = Station.new("Pavshino")
station_2 = Station.new("Depo")
station_2.trains_by_type("cargo")
station_1.take_train(train_1)
station_1.take_train(train_2)
station_1.take_train(train_3)
station_1.trains
puts station_1.trains_by_type("cargo")
station_1.send_train(train_1)
station_1.trains