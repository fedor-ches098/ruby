require_relative "wagon"

class PassengerWagon < Wagon
  def initialize(seats)
    @type = :passenger
    super
  end

  def take_place
    @used_place += 1 if free_place > 0
  end
end

# p = PassengerWagon.new(30)
# p.take_place(3)
# puts p.free_place
# puts p.used_place