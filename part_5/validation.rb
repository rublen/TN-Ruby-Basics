module Validation
  def self.included(base)
    base.class_variable_set(:@@validated_attrs, [])
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate(attr, validation_type, validation_param = nil)
      validated_attrs = class_variable_get(:@@validated_attrs)
      validated_attrs << { attr => [validation_type, validation_param] }
      class_variable_set(:@@validated_attrs, validated_attrs)
    end

    def new(*args)
      super
    rescue RuntimeError => e
      puts "#{e.message} in class #{self}"
    end
  end

  def presence(attr, truthness = nil)
    attr = eval(attr.to_s)
    attr && attr != ''
  end

  def format(attr, pattern)
    eval(attr.to_s).to_s =~ pattern
  end

  def type(attr, klass)
    eval(attr.to_s).instance_of? klass
  end

  def validate!
    validation_var = self.class.class_variable_get :@@validated_attrs
    return unless validation_var
    validation_var.each do |item|
      item.each_pair do |attr, validations|
        raise TypeError, "/**Symbol was expected" unless validations[0].is_a? Symbol
        raise "/**#{validations[0].capitalize}ErrorOfValitation of @#{attr}" unless send(validations[0], attr, validations[1])
      end
    end
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end
