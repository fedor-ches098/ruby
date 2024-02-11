require_relative "wagon"

class CargoWagon < Wagon
  def initialize(seats)
    @type = :cargo
    super
  end

  def take_place
    @used_place += 1 if free_place > 0
  end
end


c = CargoWagon.new(20)
c.take_place
c.take_place
puts c.used_place