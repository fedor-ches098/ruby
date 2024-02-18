require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_accessor :stations

  instances

  def initialize(from, to)
    @stations = [from, to]
    register_instance
    validate!
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end

  def validate!
    raise 'Станции одинаковые' if stations.map(&:name).uniq.length == 1
  end
end
