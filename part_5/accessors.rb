module Accessors
  def attr_accessor_with_history(*args)
    args.each do |inst_var|
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

    klass.define_method((inst_var.to_s + '=').to_sym) do |new_val|
      puts "in strong_attr_accessor: #{self}"
      # raise "FAILED! Invalid value" unless valid?
      instance_variable_set("@#{inst_var}".to_sym, new_val) if valid?
    # rescue RuntimeError => e
    #   puts e.message
    end
    klass.define_method(inst_var) { instance_variable_get("@#{inst_var}".to_sym) }
  end
end

class A
  extend Accessors
end

class B;
  def valid?
    raise unless qq.is_a? Integer
  rescue RuntimeError
    false
  end
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

A.strong_attr_accessor(:qq, B)
b = B.new
b.qq = 100
p b.qq
B.define_method(:ww=) { |v| instance_variable_set(:@ww, v) }
B.define_method(:ww) { instance_variable_get(:@ww) }
b.ww = 22
p b.ww
b1 = B.new
p b.instance_variables
p b1.instance_variables

