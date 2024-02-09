require_relative "wagon"

class PassengerWagon < Wagon
  attr_reader :type

  def initialize(volume)   
    @type = :passenger
    @occupied = 0
    @volume = volume 
  end

  def take_volume(value)
    unless @volume < 0 || value > @volume
      @volume -= value
      @occupied += value
    end
  end

  def occupied_volume
    @occupied
  end

  def free_volume
    @volume
  end
end
