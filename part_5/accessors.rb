require_relative 'validation'

module Accessors
  def attr_accessor_with_history(*args)
    args.each do |inst_var|
      raise ArgumentError unless inst_var.is_a? Symbol
      var_name = "@#{inst_var}".to_sym
      define_method(inst_var) { instance_variable_get(var_name) }
      define_method((inst_var.to_s + '=').to_sym) do |new_val|
        instance_variable_set(var_name, new_val)
        history_var = "@#{inst_var}_history".to_sym
        history_var_value = instance_variable_get(history_var)
        history_var_value ||= []
        instance_variable_set(history_var, history_var_value << instance_variable_get(var_name))
      end
      define_method((inst_var.to_s + '_history').to_sym) { instance_variable_get "@#{inst_var}_history".to_sym }
    end
  end

  def strong_attr_accessor(inst_var, klass)
    raise ArgumentError unless inst_var.is_a? Symbol
    # if validate inst_var, presence: true, type: klass
      define_method((inst_var.to_s + '=').to_sym) do |new_val|
        instance_variable_set("@#{inst_var}".to_sym, new_val)
      end
    # end
    define_method(inst_var) { instance_variable_get("@#{inst_var}".to_sym) }
  end
end

class A
  extend Accessors
  include Validation
  extend ClassMethods
  strong_attr_accessor :bb, Integer
  validate :bb, presence: true, type: Integer
end

class B
end

A.attr_accessor_with_history :x, :y

a = A.new
a.x = 1
a.x = 2
a.x = 3
p a.x
p a.x_history
p '------'
a.y = 11
a.y = 21
a.y = 31
p a.y
p a.y_history
p '------'
# bb = B.new
# A.strong_attr_accessor(:bb, B)
# b = B.new
a.bb = 100
p a.bb


a1 = A.new
p a.instance_variables
a1.bb = 222
p a1.bb
a1.x = 'lol'
p a1.x
p a1.instance_variables
