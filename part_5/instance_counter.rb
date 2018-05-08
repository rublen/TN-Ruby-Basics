# registration of inctances
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
  end

  # methods for extending
  module ClassMethods
    def set_counter
      class_variable_set(:@@counter, 0)
    end

    def instances
      class_variable_get(:@@counter)
    end

    def increase
      class_variable_set(:@@counter, class_variable_get(:@@counter) + 1)
    end
  end

  protected

  def register_instance
    self.class.increase
  end
end
