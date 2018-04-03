class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def get (train)
    @trains << train
  end

  def send(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
  end
end
# p Station.new('A').trains
