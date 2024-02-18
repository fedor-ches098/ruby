module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      define_method(name) { instance_variable_get("@#{name}") }
      define_method("#{name}_history") { instance_variable_get("@#{name}_history") }
      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
        history_var = instance_variable_get("@#{name}_history") || []
        instance_variable_set("@#{name}_history", history_var << value)
      end
    end
  end

  def strong_attr_accessor(name, cls)
    define_method(name) { instance_variable_get("@#{name}") }
    define_method("#{name}=") do |value|
      raise "Нерпавильный тип данных. Должен быть #{cls}" unless value.is_a? cls

      instance_variable_set("@#{name}", value)
    end
  end
end
