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
    routes.map.with_index(1) { |r, i| "#{i}. #{r.show} " }
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
      t = handle_validation(PassengerTrain, number)
      return if t == '0'
      trains << t
      "SUCCESS! Created a passenger train number #{t.number}"
    when 2
      puts '-- Create a Cargo Train --'
      print 'Enter the number of new train: '
      number = gets.chomp
      t = handle_validation(CargoTrain, number)
      return if t == '0'
      trains << t
      "SUCCESS! Created a cargo train number #{t.number}"
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
      s = handle_validation(Station, name)
      return if s == '0'
      stations << s
      "SUCCESS! Created a station #{s.name}"
    when 6
      puts '-- Create a route with two stations --'
      begin
      print 'First station of the route: '
      st_1 = handling_find_station(gets.chomp)
      print 'Last station of the route: '
      st_2 = handling_find_station(gets.chomp)
      # begin
        routes << Route.new(st_1, st_2)
      rescue RuntimeError => e
        return e
      end
      "SUCCESS! Created a route #{routes.last.show}"
    end
  end

  def route_managing(option, route)
    case option
    when 1
      puts "-- Add Station to the Route --"
      print 'Station to add: '
      st = handling_find_station(gets.chomp)
      return puts 'FAILED! The route already consists this station' if route.stations.include? st
      route.add_station(st)
      "SUCCESS! Station #{st.name} was added to the route: #{route.show}"
    when 2
      puts "-- Delete Station from the Route --"
      print "Choose a station for deleting from the list #{route.stations[1...-1].map(&:name)}: "
      st = handling_find_station(gets.chomp)
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
      print 'Station: '
      st = handling_find_station(gets.chomp)
      st.trains_on_the_station if st
    when 3
      puts "-- Display the List of All Trains --"
      return 'List of the trains is empty' if list_of_trains.empty?
      list_of_trains
    when 4
      puts "-- Display the List of All Stations --"
      return 'List of the stations is empty' if list_of_stations.empty?
      list_of_stations
    end
  end

  # helpers
  def handling_find_station(name)
    st = Station.find(name)
  rescue RuntimeError => e
    return e
  ensure st
  end

  def handle_validation(klass, init_value)
    raise 'FAILED! The list already consists this value' if klass.all.keys.include? init_value
    new_obj = klass.new(init_value)
  rescue RuntimeError => e
    puts e
    print "Try again or enter '0' for return. Enter the value: "
    init_value = gets.chomp
    return '0' if init_value == '0'
    retry
  ensure new_obj
  end

  def get_train
    return puts 'List of trains is empty' if list_of_trains.empty?
    print "Enter number of the required train: "
    number = get_valid_value(list_of_trains, gets.chomp)
    trains.find { |t| t.number == number }
  end

  def get_route
    raise 'FAILED! List of stations is empty' if Station.all.empty?
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
