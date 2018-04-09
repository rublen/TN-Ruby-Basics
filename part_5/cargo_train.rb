class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = 'cargo'
  end

  def add_one_carriage(carriage)
    return puts "Carriage type doesn't match train type" if carriage.type != type
    super
  end
end
