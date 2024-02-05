require_relative "train"

class PassengerTrain < Train
  include InstanceCounter
  
  instances()
end

passenger_train_1 = PassengerTrain.new("1344", "passenger")
passenger_train_2 = PassengerTrain.new("1355", "passenger")
puts PassengerTrain.instances