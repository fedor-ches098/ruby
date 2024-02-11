require_relative "manufacturer"

class Wagon
  include Manufacturer

  attr_reader :type, :total_place, :used_place

  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
  end

  def free_place
    total_place - @used_place
  end

  def take_place
    raise "Должен быть вызван в дочерних классах"
  end
end


#wagon_1 = Wagon.new
#wagon_1.manufacturer = "Mos-Wagon"
#puts wagon_1.manufacturer