require_relative "instance_counter"
require_relative "validate"

class Route
  include InstanceCounter
  include Validate

  attr_accessor :stations

  instances()

  def initialize(from, to)
    @stations = [from, to]
    register_instance()
    validate!()
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end
  
end

#route_1 = Route.new("Ppppp", "D")
#puts Route.instances
#puts route_1.valid?