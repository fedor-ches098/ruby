require_relative "instance_counter"

class Station
  include InstanceCounter
  
  attr_accessor :trains
  attr_reader   :name

  @@all = []

  def self.all
    @@all
  end

  instances()

  def initialize(name)
    @name = name
    @trains = []
    @@all << self
    register_instance()
  end

  def trains_by_type(type)
    self.trains.select {|train| train.type == type}.size
  end

  def add_train(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train)
  end
end

station_1 = Station.new("P")
station_2 = Station.new("D")
puts Station.instances
puts Station.all
