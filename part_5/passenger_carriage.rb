require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(space = 0)
    super
    @type = 'passenger'
    @space = space.to_i
  end
end
