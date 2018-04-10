require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize
    @type = 'passenger'
  end
end
