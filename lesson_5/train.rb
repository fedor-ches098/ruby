require_relative "instance_counter"
require_relative "manufacturer"

class Train
  include InstanceCounter
  include Manufacturer

  attr_accessor :wagons, :route, :current_station_index
  attr_reader   :number, :type

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  instances()

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @@trains[self.number] = self
    register_instance()
  end

  def add_route(route)
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

  def add_wagon(wagon)
    self.wagons << wagon
  end

  def remove_wagon
    self.wagons.delete_at(-1)
  end
end

train_1 = Train.new("1311", "cargo")
train_2 = Train.new("1333", "cargo")
puts Train.find("13333")
train_1.manufacturer = "Mos-Train"
puts Train.instances
puts train_1.manufacturer
