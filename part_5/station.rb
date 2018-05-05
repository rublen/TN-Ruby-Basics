require_relative 'instance_counter'

class Station
  NAME_FORMAT = /^[a-zа-я]+'?-?[a-zа-я]+$/i
  include InstanceCounter

  attr_reader :name, :trains
  @@all = {}
  set_counter

  def initialize(name)
    @name = name
    @trains = []
    init_validate!
    @@all[@name] = self
    register_instance
  end

  def trains_on_the_station
    get_numbers trains
  end

  def take(train)
    @trains << train unless trains.include? train
  end

  def send_off(train)
    @trains.delete(train) if trains.include? train
  end

  # cargo or passanger
  def trains_by_type(type)
    get_numbers(trains.select { |t| t.class == eval("#{type.capitalize}Train") })
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def each_train
    return trains.to_enum(:each) unless block_given?
    trains.each { |train| yield train }
  end

  def self.all
    @@all
  end

  def self.find(name)
    raise 'FAILED! There is no such station in the list' unless all[name]
    all[name]
  end

  private

  def get_numbers(list_of_trains)
    list_of_trains.map(&:number)
  end

  def validate!
    unless @name =~ NAME_FORMAT
      raise "FAILED! Your value has invalid format, use only letters and ' or -"
    end
    true
  end

  def init_validate!
    if Station.all.keys.include? @name
      raise 'FAILED! The list already consists this name'
    end
    validate!
  end
end
