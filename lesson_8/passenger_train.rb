require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter

  instances
end
