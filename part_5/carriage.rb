require_relative 'manufacturer'

class Carriage
  include Manufacturer

  attr_reader :space, :type

  def initialize(space = 0)
    @type = 'cargo'
    @space = space.to_f
    @counter = 0
    validate! if space != 0
  end

  def available
    space - counter
  end

  def taken
    counter
  end

  def take_place(value = 1) # 1 - for passenger carriage
    raise 'FAILED! There is no free seats/volume' if available < value
    self.counter += value
  end

  def valid?
    validate!
  rescue
    false
  end

  protected
  attr_accessor :counter

  private
  def validate!
    raise 'FAILED! The spaciousness in the carriage should be a number greater than 0' unless space > 0
    true
  end
end
