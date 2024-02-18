require_relative 'train'

class CargoTrain < Train
  include InstanceCounter

  instances
end
