require_relative "wagon"

class CargoWagon < Wagon
  attr_reader :type

  def initialize(seats)
    @type = :cargo
    @seats = seats
    @occupied = 0
  end

  def take_seat
    @seats -= 1
    @occupied += 1
  end

  def occupied_seats
    @occupied
  end

  def free_seats
    @seats
  end
end
