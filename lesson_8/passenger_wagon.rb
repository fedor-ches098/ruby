require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(seats)
    @type = :passenger
    super
  end

  def take_place
    @used_place += 1 if free_place.positive?
  end
end
