class PassengerTrain < Train
  def add_one_carriage(carriage)
    super(carriage) if carriage.is_a? PassCarriage
  end
end

class CargoTrain < Train
  def add_one_carriage(carriage)
    super(carriage) if carriage.is_a? CargoCarriage
  end
end

class PassCarriage
end

class CargoCarriage
end

