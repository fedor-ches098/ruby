require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Station
  include InstanceCounter
  extend Accessors
  include Validation

  attr_accessor :trains, :validation, :name
  
  attr_accessor_with_history :test
  strong_attr_accessor :strong_test, Integer
  
  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /[a-zA-Z]/
  validate :trains, :type, Array

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

  def train_block(&block)
    @trains.each do |train|
      block.call(train)
    end
  end
end


s = Station.new("P")
s.name = 11
#puts s.valid?
s.test = 10
s.test = 20
p s.test_history
s.strong_test = 1