require_relative "instance_counter"

class Station
  include InstanceCounter
  
  attr_accessor :trains
  attr_reader   :name

  @@instances = 0

  def self.all
    @@instances
  end

  instances()

  def initialize(name)
    @name = name
    @trains = []
    @@instances += 1
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
