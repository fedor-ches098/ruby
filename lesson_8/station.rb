require_relative 'instance_counter'
require_relative 'validate'

class Station
  include InstanceCounter
  include Validate

  attr_accessor :trains, :validation, :name

  def self.all
    @all ||= []
  end

  instances

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
    validate!
    register_instance
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }.size
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def validate!
    raise 'Имя пустое' if name.empty?
  end

  def train_block(&block)
    @trains.each do |train|
      block.call(train)
    end
  end
end
