class RailRoad
  attr_accessor :stations, :trains, :routes, :carriages
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def list_of_stations
    stations.map(&:name)
  end

  def list_of_trains
    trains.map(&:number)
  end

  def list_of_routes
    routes.map.each_with_index { |r, i| "#{i + 1}. #{r.show.join('-').chomp('-')} " }
  end

  def list_of_carriages_by_type(type)
    carriages.select { |c| c.type == type }
  end

  def creating(option)
    case option
    when 1
      puts "-- Create a Passenger Train --"
      print 'Enter the number of new train: '
      trains << PassengerTrain.new(gets.chomp)
    when 2
      puts "-- Create a Cargo Train --"
      print 'Enter the number of new train: '
      trains << CargoTrain.new(gets.chomp)
    when 3
      puts "-- Create a Passenger Carriage --"
      carriages << PassengerCarriage.new
    when 4
      puts "-- Create a Cargo Carriage --"
      carriages << CargoCarriage.new
    when 5
      puts "-- Create a Station --"
      print 'Enter the name of new station: '
      stations << Station.new(gets.chomp)
    when 6
      puts '-- Create a route with two stations --'
      puts 'First station of the route'
      st_1 = get_station
      return unless st_1
      puts 'Last station of the route'
      st_2 = get_station
      return unless st_2
      routes << Route.new(st_1, st_2)
    end
  end

  def route_managing(option, route)
    case option
    when 1
      puts "-- Add Station to the Route --"
      st = get_station
      route.add_station(st)
    when 2
      puts "-- Delete Station from the Route --"
      print "Choose a station for deletin from the list #{route.stations[1...-1].map(&:name)}: "
      name = gets.chomp
      st = stations.find { |s| s.name == name}
      route.delete_station(st) if route.stations.include? st
      route.stations.map(&:name)
    end
  end

  def train_managing(option, train)
    case option
    when 1
      puts "-- Set the Route for Train --"
      route = get_route
      train.route = route if route
    when 2
      puts "-- Add Carriage to Train --"
      carriage = list_of_carriages_by_type(train.type).first
      return unless carriage
      train.add_one_carriage(carriage)
      carriages.delete(carriage)
      p train.carriages
      puts "amount of carriages: #{train.carriages.size}"
    when 3
      puts "-- Remove Carriage from Train --"
      carriages << train.remove_one_carriage
      puts "amount of carriages: #{train.carriages.size}"
    when 4
      puts "-- Move the Train to the Next Station --"
      return unless train.route
      train.move_to_next_station
      puts "Current station: #{train.current_station.name}"
    when 5
      puts "-- Move the Train to the Previous Station --"
      return unless train.route
      train.move_to_previous_station
      puts "Current station: #{train.current_station.name}"
    end
  end

  def info(option)
    case option
    when 1
      puts "-- Display the Route --"
      route = get_route
      route.show if route
    when 2
      puts "-- Display the List of Trains on the Station --"
      st = get_station
      st.trains_on_the_station if st
    when 3
      puts "-- Display the List of All Trains --"
      list_of_trains
    end
  end

  def get_train
    print "Enter number of the required train: "
    number = get_valid_value(list_of_trains, gets.chomp)
    trains.find { |t| t.number == number }
  end

  def get_route
    p list_of_routes
    print "Choose the route by its number (1, 2, ...): "
    n = gets.to_i
    return if n < 1
    route = routes[n - 1]
    return puts "There is no route ##{n}" unless route
    route
  end

  def start
    loop do
      puts MAIN_MENU
      print "Enter a MENU option: "
      menu_option = gets.to_i
      case menu_option
      when 1
        puts CREATING_MENU
        loop do
          print "\nEnter a CREATING option: "
          option = gets.to_i
          p creating(option)
          break if option.zero?
        end

      when 2
        puts "\n___MANAGING ROUTES MENU___"
        route = get_route
        puts MANAGING_ROUTES_MENU
        loop do
          print "\nEnter a MANAGING ROUTES option: "
          option = gets.to_i
          p route_managing(option, route)
          break if option.zero?
        end

      when 3
        puts "\n___MANAGING TRAINS MENU___"
        train = get_train
        puts MANAGING_TRAINS_MENU
        loop do
          print "\nEnter a MANAGING TRAINS option: "
          option = gets.to_i
          p train_managing(option, train)
          break if option.zero?
        end

      when 4
        puts INFO_MENU
        loop do
          print "\nEnter a INFO option: "
          option = gets.to_i
          p info(option)
          break if option.zero?
        end
      else
        exit
      end
    end
  end

  # эти методы вызываются только внутри класса RailRoad
  private
  def get_station
    print 'Name of station: '
    name = get_valid_value(list_of_stations, gets.chomp)
    stations.find { |s| s.name == name }
  end

  def get_valid_value(arr, value)
    until arr.include? value
      puts "No such item in the list"
      puts "  enter '1' to get the list of available items
  enter '0' for return
  or just enter another value"
    print 'Your choice: '
      choice = gets.chomp
      case choice
      when '1' then p arr
      when '0' then return
      else
        value = choice
      end
    end
    value
  end
end
