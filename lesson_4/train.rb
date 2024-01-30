class Train
  attr_accessor :wagons, :route, :current_station_index
  attr_reader   :number, :type, :wagon_type

  def initialize(number, type, wagon_type)
    @number = number
    @type = type
    @wagon_type = wagon_type
    @wagons = []
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