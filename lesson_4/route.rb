class Route
  attr_accessor :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end
  
end