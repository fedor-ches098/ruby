module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :count
    
    def instances
      @count ||= 0
    end
  end

  module InstanceMethods

    private

    def register_instance
      self.class.count += 1
    end
  end
end

=begin
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      @count ||= 0
    end

    private 

    def count
      @count = self.instances + 1
    end
  end

  module InstanceMethods

    private

    def register_instance
      self.class.send :count
    end
  end
end
=end