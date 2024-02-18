module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attribute, type, *options)
      @result ||= []
      @result << [attribute, type, options]
    end

    def check(instance)
      @result.each do |value|
        inst_var = instance.instance_variable_get(:"@#{value[0]}")
        case value[1]
        when :presence
          raise 'Атрибут не должен быть nil' if inst_var.nil?

          raise "Атрибут #{value[0]} не должен быть пустой строкой" if inst_var.instance_of?(String) && inst_var.empty?
        when :type
          raise "Атрибут #{value[0]} неправильного типа данных" if inst_var.class != value[2][0]
        when :format
          raise "Атрибут #{value[0]} неверного формата" if inst_var.to_s !~ value[2][0]
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.check(self)
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
