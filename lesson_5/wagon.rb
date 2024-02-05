require_relative "manufacturer"

class Wagon
  include Manufacturer

  attr_reader :type
end


wagon_1 = Wagon.new
wagon_1.manufacturer = "Mos-Wagon"
puts wagon_1.manufacturer