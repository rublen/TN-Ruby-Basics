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
    routes.map.each_with_index { |r, i| "#{i + 1}. #{r.show} " }
  end

  def list_of_carriages_by_type(type)
    carriages.select { |c| c.type == type }
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
          puts creating(option)
          break if option.zero?
        end

      when 2
        puts "\n___MANAGING ROUTES___"
        route = get_route
        next unless route
        puts "\n___MANAGING ROUTES MENU___"
        puts MANAGING_ROUTES_MENU
        loop do
          print "\nEnter a MANAGING ROUTES option: "
          option = gets.to_i
          puts route_managing(option, route)
          break if option.zero?
        end

      when 3
        puts "\n___MANAGING TRAINS___"
        train = get_train
        next unless train
        puts "\n___MANAGING TRAINS MENU___"
        puts MANAGING_TRAINS_MENU
        loop do
          print "\nEnter a MANAGING TRAINS option: "
          option = gets.to_i
          puts train_managing(option, train)
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

  private

  def creating(option)
    case option
    when 1
      puts '-- Create a Passenger Train --'
      print 'Enter the number of new train: '
      number = gets.chomp
      raise if list_of_trains.include? number
      trains << PassengerTrain.new(number)
      "SUCCESS! Created a passenger train number #{number}"
    when 2
      puts '-- Create a Cargo Train --'
      print 'Enter the number of new train: '
      number = gets.chomp
      raise if list_of_trains.include? number
      trains << CargoTrain.new(number)
      "SUCCESS! Created a cargo train number #{number}"
    when 3
      puts "-- Create a Passenger Carriage --"
      carriages << PassengerCarriage.new
      "SUCCESS! Created a passenger carriage"
    when 4
      puts "-- Create a Cargo Carriage --"
      carriages << CargoCarriage.new
      "SUCCESS! Created a cargo carriage"
    when 5
      puts "-- Create a Station --"
      print 'Enter the name of new station: '
      name = gets.chomp
      raise if list_of_stations.include? name
      stations << Station.new(name)
      "SUCCESS! Created a station #{name}"
    when 6
      puts '-- Create a route with two stations --'
      puts 'First station of the route'
      st_1 = get_station
      return unless st_1
      puts 'Last station of the route'
      st_2 = get_station
      return unless st_2
      routes << Route.new(st_1, st_2)
      "SUCCESS! Created a route #{routes.last.show}"
    end
  rescue RuntimeError
    puts 'FAILED! The list already consists such item'
    return
  end

  def route_managing(option, route)
    case option
    when 1
      puts "-- Add Station to the Route --"
      st = get_station
      return puts 'FAILED! The route already consists this station' if route.stations.include? st
      route.add_station(st)
      "SUCCESS! Station #{st.name} was added to the route: #{route.show}"
    when 2
      puts "-- Delete Station from the Route --"
      print "Choose a station for deleting from the list #{route.stations[1...-1].map(&:name)}: "
      name = gets.chomp
      st = route.stations.find { |s| s.name == name}
      return 'FAILED! There is no such station in this route' unless st
      route.delete_station(st)
      "SUCCESS! Station #{st.name} was deleted from the route: #{route.show}"
    end
  end

  def train_managing(option, train)
    case option
    when 1
      puts "-- Set the Route for Train --"
      route = get_route
      train.route = route if route
      "SUCCESS! Train number #{train.number} got the route: #{route.show}"
    when 2
      puts "-- Add Carriage to Train --"
      carriage = list_of_carriages_by_type(train.type).first
      return 'FAILED! There are no appropriate carriages' unless carriage
      train.add_one_carriage(carriage)
      carriages.delete(carriage)
      "SUCCESS! A carriage was added to train number #{train.number}, amount of its carriages: #{train.carriages.size}"
    when 3
      puts "-- Remove Carriage from Train --"
      return "FAILED! This train hasn't carriages" if train.carriages.empty?
      carriages << train.remove_one_carriage
      "SUCCESS! A carriage was removed from train number #{train.number}, amount of its carriages: #{train.carriages.size}"
    when 4
      puts "-- Move the Train to the Next Station --"
      return "FAILED! This train has no any route. First set the route" unless train.route
      return "FAILED! Current station #{train.current_station.name} is the last station of the route" unless train.move_to_next_station
      "SUCCESS! Current station: #{train.current_station.name}"
    when 5
      puts "-- Move the Train to the Previous Station --"
      return "FAILED! This train has no any route. First set the route" unless train.route
      return "FAILED! Current station #{train.current_station.name} is the first station of the route" unless train.move_to_previous_station
      "SUCCESS! Current station: #{train.current_station.name}"
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
      return 'List of the trains is empty' if list_of_trains.empty?
      list_of_trains
    end
  end

  def get_station
    return puts 'List of stations is empty' if list_of_stations.empty?
    print 'Name of station: '
    name = get_valid_value(list_of_stations, gets.chomp)
    stations.find { |s| s.name == name }
  end

   def get_train
    return puts 'List of trains is empty' if list_of_trains.empty?
    print "Enter number of the required train: "
    number = get_valid_value(list_of_trains, gets.chomp)
    trains.find { |t| t.number == number }
  end

  def get_route
    return puts 'List of routes is empty' if list_of_routes.empty?
    p list_of_routes
    print "Choose the route by its number (1, 2, ...): "
    n = gets.to_i
  raise "FAILED! Invalide number" if n < 1
    route = routes[n - 1]
  raise "FAILED! There is no route ##{n}" unless route
  rescue RuntimeError => e
    puts e
    retry
  ensure
    return route
  end

  def get_valid_value(arr, value)
    raise "FAILED! No such item in the list" unless arr.include? value
  rescue RuntimeError => e
    puts e
    puts "  enter '1' to get the list of available items\n  enter '0' for return\n  or just enter another value"
    print 'Your choice: '
    choice = gets.chomp
    case choice
    when '1'
      p arr
      print 'Choose the value: '
      value = gets.chomp
      retry
    when '0' then return
    else
      value = choice
      retry
    end
    ensure return value
  end
end
