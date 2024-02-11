require_relative "wagon"

class CargoWagon < Wagon
  def initialize(volume)   
    @type = :cargo
    super
  end
  
  def take_place(volume)
    @used_place += volume if free_place >= volume
  end
end


#c = CargoWagon.new(20)
#c.take_place
#c.take_place
#puts c.used_place