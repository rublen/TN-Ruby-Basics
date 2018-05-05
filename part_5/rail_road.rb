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
      print 'Enter a MENU option: '
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
          info(option)
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
      t = handle_init_validation(PassengerTrain, number)
      return if t == '0'
      trains << t
      "SUCCESS! Created a passenger train number #{t.number}"
    when 2
      puts '-- Create a Cargo Train --'
      print 'Enter the number of new train: '
      number = gets.chomp
      t = handle_init_validation(CargoTrain, number)
      return if t == '0'
      trains << t
      "SUCCESS! Created a cargo train number #{t.number}"
    when 3
      puts '-- Create a Passenger Carriage --'
      car = create_carriage(PassengerCarriage)
      return unless car
      "SUCCESS! Created a passenger carriage with #{car.space} seats"
    when 4
      puts '-- Create a Cargo Carriage --'
      car = create_carriage(CargoCarriage)
      return unless car
      "SUCCESS! Created a cargo carriage with volume of #{car.space}"
    when 5
      puts '-- Create a Station --'
      print 'Enter the name of new station: '
      name = gets.chomp
      s = handle_init_validation(Station, name)
      return if s == '0'
      stations << s
      "SUCCESS! Created a station #{s.name}"
    when 6
      puts '-- Create a route with two stations --'
      print 'The first station of the route: '
      st1 = handling_find_station(gets.chomp)
      print 'The last station of the route: '
      st2 = handling_find_station(gets.chomp)
      r = handling_route_new(st1, st2)
      return r unless r.is_a? Route
      routes << r
      "SUCCESS! Created a route #{routes.last.show}"
    end
  end

  def route_managing(option, route)
    case option
    when 1
      puts '-- Add Station to the Route --'
      print 'Station to add: '
      st = handling_find_station(gets.chomp)
      return st unless st.is_a? Station
      return 'FAILED! The route already consists this station' if route.stations.include? st
      route.add_station(st)
      "SUCCESS! Station #{st.name} was added to the route: #{route.show}"
    when 2
      puts '-- Delete Station from the Route --'
      print "Choose a station for deleting from the list #{route.stations[1...-1].map(&:name)}: "
      st = handling_find_station(gets.chomp)
      return st unless st.is_a? Station
      route.delete_station(st)
      "SUCCESS! Station #{st.name} was deleted from the route: #{route.show}"
    end
  end

  def train_managing(option, train)
    case option
    when 1
      puts '-- Set the Route for Train --'
      route = get_route
      return route unless route.is_a? Route
      train.route = route
      "SUCCESS! Train number #{train.number} got the route: #{route.show}"
    when 2
      puts '-- Add Carriage to Train --'
      carriage = list_of_carriages_by_type(train.type).first
      return 'FAILED! There are no appropriate carriages' unless carriage
      train.add_one_carriage(carriage)
      carriages.delete(carriage)
      "SUCCESS! Added. Train #{train.number} has #{train.carriages.size} carriages"
    when 3
      puts '-- Remove Carriage from Train --'
      return "FAILED! This train hasn't carriages" if train.carriages.empty?
      carriages << train.remove_one_carriage
      "SUCCESS! Removed. Train #{train.number} has #{train.carriages.size} carriages"
    when 4
      puts '-- Move the Train to the Next Station --'
      return 'FAILED! This train has no any route. Set the route' unless train.route
      return "FAILED! #{train.current_station.name} is the last station of route" unless train.move_to_next_station
      "SUCCESS! Current station: #{train.current_station.name}"
    when 5
      puts '-- Move the Train to the Previous Station --'
      return 'FAILED! This train has no any route. Set the route' unless train.route
      return "FAILED! #{train.current_station.name} is the first station of route" unless train.move_to_previous_station
      "SUCCESS! Current station: #{train.current_station.name}"
    when 6
      puts '-- Take Seats/Volume in the Carriage --'
      print "This train has #{train.carriages.size} carriages. Enter number of required carriage: "
      n = gets.to_i
      return 'FAILED! Invalid number' if n <= 0 || n > train.carriages.size
      begin
        car = train.carriages[n - 1]
        puts "This carriage has free #{car.available} seats/volume"
        if car.is_a?(PassengerCarriage)
          car.take_place
          return "SUCCESS! Now #{car.available} free seats left in this carriage"
        end
        print 'Enter requier volume: '
        car.take_place(gets.to_f)
        return "SUCCESS! Now #{car.available} of volume left in this carriage"
      rescue RuntimeError => e
        return e.message
      end
    end
  end

  def info(option)
    case option
    when 1
      puts '-- Display the Route --'
      route = get_route
      puts route.show if route
    when 2
      puts '-- Display Detailed List of Trains on the Station --'
      print 'Station: '
      st = handling_find_station(gets.chomp)
      return st unless st.is_a? Station
      st.each_train do |t|
        puts "#{t.number}, #{t.type}, number of carriages: #{t.carriages.size}"
        t.each_carriage.with_index(1) do |car, i|
          puts "  Carriage ##{i}. #{car.type.capitalize}. Available: #{car.available}. Taken: #{car.taken}"
        end
      end
    when 3
      puts '-- Display the List of All Trains --'
      return puts 'List of the trains is empty' if list_of_trains.empty?
      p list_of_trains
    when 4
      puts '-- Display the List of All Stations --'
      return puts 'List of the stations is empty' if list_of_stations.empty?
      p list_of_stations
    when 5
      puts '-- Display Details about Train --'
      t = get_train
      return if t == '0'
      t.each_carriage.with_index(1) do |car, i|
        puts "  Carriage ##{i}. #{car.type.capitalize}. Available: #{car.available}. Taken: #{car.taken}"
      end
    end
  end

  # helpers
  def handle_init_validation(klass, init_value)
    new_obj = klass.new(init_value)
  rescue RuntimeError => e
    puts e.message
    print "Try again or enter '0' for return. Enter the value: "
    init_value = gets.chomp
    return '0' if init_value == '0'
    retry
  ensure new_obj
  end

  def create_carriage(klass_car)
    print 'Enter amount of seats/volume (int/float, >= 0): '
    space = gets.chomp
    if space == '0'
      car = klass_car.new
    else
      car = handle_init_validation(klass_car, space)
      return if car == '0'
    end
    carriages << car
    car
  end

  def handling_find_station(name)
    st = Station.find(name)
  rescue RuntimeError => e
    return e.message
  ensure st
  end

  def handling_route_new(start_st, end_st)
    r = Route.new(start_st, end_st)
  rescue RuntimeError => e
    return e.message
  ensure r
  end

  def get_route
    return puts 'List of routes is empty' if list_of_routes.empty?
    p list_of_routes
    print 'Choose the route by its number (1, 2, ...): '
    n = gets.to_i
    get_route if n < 1
    route = routes[n - 1]
    get_route unless route
    route
  end

  # handling Train.find(number)
  def get_train
    return puts 'List of trains is empty' if list_of_trains.empty?
    print "Enter number of the required train or '0' for return: "
    number = gets.chomp
    return if number == '0'
    t = Train.find(number)
  rescue RuntimeError => e
    puts e.message
    get_train unless t
  ensure t
  end
end
