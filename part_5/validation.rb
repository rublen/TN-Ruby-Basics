module Validation
  module ClassMethods
    # validate(attr, presense: true, format: /A-Z/, type: String)
    def validate(value, validations)
      define_method :initialize do |*args|
        super *args
        validate!(value, validations)
      end
      class << self
        def new(*args)
          super
        rescue ArgumentError => e
          puts "#{e.message} of validation in class #{self}"
        end
      end
    end
  end

  def validate!(attr, validations = {})
    validations.each do |v_type, v_param|
      raise ArgumentError unless v_type.is_a? Symbol
      raise "#{v_type.capitalize}ValitationError" unless self.send(v_type, attr, v_param)
    end
  end

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
