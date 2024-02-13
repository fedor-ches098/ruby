require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validate'

class Train
  include InstanceCounter
  include Manufacturer
  include Validate

  attr_accessor :wagons, :route, :current_station_index
  attr_reader   :number, :type

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  def self.trains
    @trains ||= {}
  end

  def self.find(number)
    @trains[number]
  end

  instances

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    self.class.trains[self.number] = self
    validate!
    register_instance
  end

  def add_route(route)
    self.route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  def go_next_station
    current_station.send_train(self)
    @current_station_index += 1 if next_station
    current_station.add_train(self)
  end

  def go_previous_station
    current_station.send_train(self)
    @current_station_index -= 1 if previous_station
    current_station.add_train(self)
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
    wagons << wagon
  end

  def remove_wagon
    wagons.delete_at(-1) unless wagons.empty?
  end

  def validate!
    raise 'Номер пустой' if number.empty?
    raise 'Номер не соответствует формату' if number !~ NUMBER_FORMAT
  end

  def wagon_block(&block)
    @wagons.each do |wagon|
      block.call(wagon)
    end
  end
end
