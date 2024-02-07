require_relative "train"

class PassengerTrain < Train
  include InstanceCounter
  
  instances()

end

#passenger_train_1 = PassengerTrain.new("133-вв", "passenger")
#p passenger_train_1
#passenger_train_2 = PassengerTrain.new("1355", "passenger")
#puts PassengerTrain.instances