require_relative 'manufacturer'

class Carriage
  include Manufacturer

  attr_reader :type
  def initialize
    @type = 'cargo'
  end
end
