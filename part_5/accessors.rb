require_relative 'validation'

module Accessors
  def attr_accessor_with_history(*args)
  # для каждого атрибута из массива args создается геттер и сеттер, геттер - простой,
  # а сеттер создает еще одну инстанс-переменную @имя_атрибута_history (напр., @name_history),
  # эта переменная - массив, в который добавляются все значения атрибута; для этой переменной определяется метод-геттер
    args.each do |inst_var|
      raise ArgumentError unless inst_var.is_a? Symbol
      var_name = "@#{inst_var}".to_sym
      define_method(inst_var) { instance_variable_get(var_name) }
      define_method("#{inst_var}=".to_sym) do |new_val|
        history_var = "@#{inst_var}_history".to_sym
        history_var_value = Array(instance_variable_get(history_var))
        instance_variable_set(var_name, new_val)
        instance_variable_set(history_var, history_var_value << instance_variable_get(var_name))
      end
      define_method("#{inst_var}_history".to_sym) { instance_variable_get "@#{inst_var}_history".to_sym }
    end
  end

  def strong_attr_accessor(inst_var, klass)
    raise ArgumentError unless inst_var.is_a? Symbol
    define_method("#{inst_var}=".to_sym) do |new_val|
      raise TypeError, "Wrong value for instance variable @#{inst_var} in class #{self.class}" unless new_val.is_a? klass
      instance_variable_set("@#{inst_var}".to_sym, new_val)
    end
    define_method(inst_var) { instance_variable_get "@#{inst_var}".to_sym }
  end
end

# class A
#   extend Accessors
#   include Validation

#   attr_accessor_with_history :x, :y
#   strong_attr_accessor :y, Numeric
#   validate :x, presence: true, type: Integer, format: /[1-9]/

#   def initialize(x, y)
#     puts @@validated_attrs
#     puts "init"
#     @x = x
#     @y = y
#     validate!
#   end

#   def v_attr
#     @@validated_attrs
#   end
# end

# a = A.new(6, 5)
# p a.v_attr

# a.x = 1
# a.x = 2
# a.x = 3
# p a.x
# p a.x_history
# p '------'
# a.y = 11
# a.y = 21
# a.y = 31
# p a.y
# p a.y_history
# p '------'


# a1 = A.new(100, 200)
# p a.instance_variables
# a1.y = 222
# p a1.y
# a1.y = 2.5
# p a1.y
# p a1.instance_variables
