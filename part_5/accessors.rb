require_relative 'validation'

module Accessors
  def attr_accessor_with_history(*args)
  # для каждого атрибута из массива args (напр., @x) создается геттер и сеттер, а также создается геттер
  # для еще одной инстанс-переменной @имя_атрибута_history (напр., @x_history), при чем начальное значение
  # этой переменной должно быть установлено как пустой массив, в который будут добавляться все новые значения атрибута @x через его сеттер
    args.each do |inst_var|
      raise TypeError, "/**Symbol was expected" unless inst_var.is_a? Symbol
      var_name = "@#{inst_var}".to_sym
      var_name_history = "@#{inst_var}_history".to_sym
      define_method(inst_var) { instance_variable_get var_name }
      define_method("#{inst_var}_history".to_sym) { instance_variable_get var_name_history }
      define_method("#{inst_var}=".to_sym) do |new_val|
        instance_eval("#{var_name_history} ||= []")
        instance_variable_set(var_name, new_val)
        instance_variable_set(var_name_history, (eval(var_name_history.to_s) << new_val))
      end
    end
  end

  def strong_attr_accessor(inst_var, klass)
    # сопоставляет значение inst_var с классом klass только при вызове сеттера для inst_var
    raise TypeError, "/**Symbol was expected" unless inst_var.is_a? Symbol
    define_method("#{inst_var}=".to_sym) do |new_val|
      raise TypeError, "/**Invalid value for setting instance-variable @#{inst_var} in class #{self.class}" unless new_val.is_a? klass
      instance_variable_set("@#{inst_var}".to_sym, new_val)
    end
    define_method(inst_var) { instance_variable_get "@#{inst_var}".to_sym }
  end
end
