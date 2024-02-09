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

  def train_block(&block)
    @trains.each do |train|
      block.call(train)
    end
  end
end

#station_1 = Station.new("Pavshino")
#station_1.add_train("train1")
#station_1.add_train("train2")
#station_1.train_block {|x| puts x}
