module Validation
  def self.included(base)
    base.class_variable_set(:@@validated_attrs, nil)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate(attr, validations)
    # validate :number, presense: true, format: /A-Z/, type: String
      validated_attrs ||= {}
      validated_attrs[attr] = validations
      class_variable_set(:@@validated_attrs, validated_attrs)
    end
    def new(*args)
      super
    rescue RuntimeError => e
      puts "#{e.message} in class #{self}"
    end
  end

  def presence(attr, truthness)
    attr = eval(attr.to_s)
    !!(attr && attr != '') == truthness
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
    validation_var.each_pair do |attr, validations|
      validations.each_pair do |valid_type, valid_param|
        raise ArgumentError unless valid_type.is_a? Symbol
        raise "#{valid_type.capitalize}ErrorOfValitation" unless send valid_type, attr, valid_param
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
