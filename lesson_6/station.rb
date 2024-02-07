require_relative "instance_counter"
require_relative "validate"

class Station
  include InstanceCounter
  include Validate
  
  attr_accessor :trains, :validation, :name

  @@all = []

  def self.all
    @@all
  end

  instances()

  def initialize(name)
    @name = name
    @trains = []
    @@all << self
    validate!()
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

#station_1 = Station.new("ppp")
#station_1.name = "ppppppppp"
#puts station_1.valid?
#station_2 = Station.new("D")
#puts Station.instances
#puts Station.all