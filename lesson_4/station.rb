class Station
  attr_accessor :trains
  attr_reader   :name

  def initialize(name)
    @name = name
    @trains = []
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