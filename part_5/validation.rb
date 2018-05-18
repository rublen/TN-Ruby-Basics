module Validation
  module ClassMethods
    # validate attr, presense: true, format: /A-Z/, type: String
    def validate(attr, validations)
      p "in validate"
      validated_attrs ||= {}
      validated_attrs[attr] = validations
      class_variable_set(:@@validated_attrs, validated_attrs)
      p class_variable_get :@@validated_attrs
      p "in validate"
    end
    def new(*args)
      super
    rescue ArgumentError => e
      puts "#{e.message} of validation in class #{self}"
    end
  end

  def method_missing(name, *args)
    if name == :validate!
      self.class.send(:define_method, :validate!, lambda do |args|
        args.each do |attr, validations|
          validations.each do |valid_type, valid_param|
            raise ArgumentError unless valid_type.is_a? Symbol
            p "Presence: #{presence(attr, true)}"
            raise "#{valid_type.capitalize}ValitationError" unless self.send(valid_type, attr, valid_param)
          end
        end
      end)
      validate!(self.class.class_variable_get :@@validated_attrs)
    end
    super
  end

  #some method with method_missing - ???

  def presence(attr, truthness)
    !!(attr && attr != '') == truthness
  end

  def format(attr, pattern)
    attr === pattern
  end

  def type(attr, klass)
    attr.instance_of? klass
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end
