module Validation
  def self.included(base)
    base.class_variable_set(:@@validations, [])
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate(attr, validation_type, validation_param = nil)
      validations = class_variable_get(:@@validations)
      validations << { attr => [validation_type, validation_param] }
      class_variable_set(:@@validations, validations)
    end
  end

  def presence(attr_value, _truthness = nil)
    attr_value && attr_value != ''
  end

  def format(attr_value, pattern)
    attr_value =~ pattern
  end

  def type(attr_value, klass)
    attr_value.instance_of? klass
  end

  def validate!
    validations = self.class.class_variable_get :@@validations
    return unless validations
    validations.each do |item|
      item.each_pair do |attr, valids|
        raise TypeError, "/**Symbol was expected" unless valids[0].is_a? Symbol
        raise "/**#{valids[0].capitalize}ErrorOfValitation of @#{attr}" unless send(valids[0], instance_variable_get("@#{attr}".to_sym), valids[1])
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
