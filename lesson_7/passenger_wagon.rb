require_relative "wagon"

class PassengerWagon < Wagon

  def initialize(volume)   
    @type = :passenger
    super
  end

  def take_place(volume)
    @used_place += volume if free_place >= volume
  end
end

# p = PassengerWagon.new(30)
# p.take_place(3)
# puts p.free_place
# puts p.used_place