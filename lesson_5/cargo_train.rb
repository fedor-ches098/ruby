require_relative "train"

class CargoTrain < Train
  include InstanceCounter
  
  instances()
end

cargo_train_1 = CargoTrain.new("1433", "cargo")
puts CargoTrain.instances