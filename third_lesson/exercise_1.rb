class Station
  attr_accessor :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def show_trains
    @trains.each {|train| puts "Train number: #{train.number} now in station: #{self.name}"}
  end

  def show_trains_by_type(type)
    if (type != "cargo") && (type != "passenger")
      puts "Error! Type must be 'cargo' or 'passenger'"
      return @trains
    end

    @trains.select {|train| puts "Train number: #{train.number} with type #{train.type} now in station: #{self.name}" if train.type == type}
  end

  def take_train(train)
    @trains << train
    puts "Take train: #{train.number} to station: #{self.name}"
  end

  def send_train(train)
    @trains.delete(train)
    puts "Send train: #{train.number} from station: #{self.name}"
  end
end

class Route
  attr_accessor :stations
  def initialize(from, to)
    @stations = [from, to]
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
    puts "Add intermediate station: #{station}. Stations: #{@stations}"
  end

  def remove_intermediate_station(station)
    unless @stations.include? station
      puts "Error! Can not find intermediate station: '#{station}' in stations array"
      return @stations
    end
        
    if (station == @stations[0]) || (station == @stations[-1])
      puts "Error! Can not remove first or last station"
      return @stations
    else
      @stations.delete(station)
      puts "Remove intermediate station: #{station}. Stations: #{@stations}"
    end
  end

  def show_stations
    @stations.each {|station| puts "Station: #{station} in route"}
  end
end

class Train
  attr_accessor :speed, :car_count, :route, :current_station
  attr_reader   :number, :type
  def initialize(number, type, car_count)
    @number = number
    @type = type
    @speed = 0
    @car_count = car_count
  end

  def stop
    @speed = 0
    puts "Train: #{self.number} is stopped. Speed: #{@speed}"
  end

  def change_car_count(action)
    if (@car_count == 0) && (action == "remove")
      puts "Nothing to remove!" 
      return @car_count
    end

    unless @speed == 0
      puts "Error! Train: #{self.number} is going"
      return @car_count
    end

    if action == "remove"
      @car_count -= 1 
      puts "Remove car for train: #{self.number}! Count: #{@car_count}"
    elsif action == "add"   
      @car_count += 1
      puts "Add car for train: #{self.number}! Count: #{@car_count}"
    else    
      puts "Error! Action must be 'add' or 'remove'"
    end
  end

  def take_route(route)
    self.route = route
    puts "Train: #{self.number} take route: #{route.stations}"
    self.current_station = route.stations[0]
    puts "Train's: #{self.number} current station: #{current_station}"
  end

  def move_train(direction)
    if route.nil?
      puts "Error! Route not assign for train: #{self.number}"
      return false
    end

    if (self.current_station == self.route.stations[0]) && (direction == "back")
      puts "Error! Train: #{self.number} in first route station"
      return self.current_station
    end

    if direction == "forward"
      self.current_station = route.stations[route.stations.find_index(self.current_station) + 1]
      puts "Train: #{self.number} go forward. Current station: #{self.current_station}" 
    end

    if direction == "back"
      self.current_station = route.stations[route.stations.find_index(self.current_station) - 1]
      puts "Train: #{self.number} go back. Current station: #{self.current_station}"
    end
  end

  def show_train_route_info
    if route.nil?
      puts "Error! Route not assign for train: #{self.number}"
      return false
    end

    puts "Previous station: #{route.stations[route.stations.find_index(self.current_station) - 1]} for train: #{self.number}"
    puts "Current station: #{self.current_station} for train: #{self.number}"
    puts "Next station: #{route.stations[route.stations.find_index(self.current_station) + 1]} for train: #{self.number}"
  end
end

puts "-----------------------------------------"
route = Route.new("Pavshino", "Dmitrovskaya")
route.add_intermediate_station("Tyshinskaya")
route.add_intermediate_station("Shukinskaya")
route.remove_intermediate_station("Shukinskaya")
route.show_stations
puts "-----------------------------------------"
train_1 = Train.new("1490", "cargo", 20)
train_2 = Train.new("1500", "passenger", 10)
train_3 = Train.new("1495", "cargo", 15)
train_1.take_route(route)
train_1.move_train("forward")
train_1.move_train("forward")
train_1.move_train("back")
train_1.show_train_route_info
train_2.move_train("forward")
train_2.show_train_route_info
train_3.change_car_count("add")
puts "-----------------------------------------"
station = Station.new("Pavshino")
station.take_train(train_1)
station.take_train(train_2)
station.take_train(train_3)
station.show_trains
station.show_trains_by_type("cargo")
station.send_train(train_1)
station.show_trains