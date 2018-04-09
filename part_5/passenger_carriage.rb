require_relative 'carriage'

class PassengerCarriage < Carriage
  attr_reader :type

  def initialize
    @type = 'passenger'
  end

  def add_one_carriage(carriage)
    return puts "Carriage type doesn't match train type" if carriage.type != type
    super
  end
end
