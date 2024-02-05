require_relative "instance_counter"

class Route
  include InstanceCounter

  attr_accessor :stations

  instances()

  def initialize(from, to)
    @stations = [from, to]
    register_instance()
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end
  
end

route_1 = Route.new("P", "D")
puts Route.instances