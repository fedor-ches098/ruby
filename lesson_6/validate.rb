module Validate
  def valid?
    validate!()
    true
  rescue   
    false
  end

  protected 

  def validate!
    case self.class.name
    when "Station"
      raise "Имя слишком длинное" if self.name.length > 10
      raise "Имя пустое" if self.name.nil?
    when /.*Train$/
      raise "Неправильный формат номера" if self.number !~ self.class::NUMBER_FORMAT
    when "Route"
      raise "Станций нет" if self.stations.empty?
    end
    true
  end
end