def creating(option, road)
  case option
  when 1
    print 'Number of train: '
    road.trains << PassengerTrain.new(gets.chomp)
  when 2
    print 'Number of train: '
    road.trains << CargoTrain.new(gets.chomp)
  when 3
    road.wagons << PassCarriage.new
  when 4
    road.wagons << CargoCarriage.new
  when 5
    print 'Name of the station: '
    road.stations << Station.new(gets.chomp)
  when 6
    puts 'Creating of the route with two stations:'
    print 'Name of the first station: '
    st_1 = Station.new(gets.chomp)
    print 'Name of the last station: '
    st_2 = Station.new(gets.chomp)
    road.stations << st_1 << st_2
    road.routes << Route.new(st_1, st_2)
  end
end

def managing(option, train, route, road)
  case option
  when 1
    print 'Name of additional station: '
    road.stations << Station.new(gets.chomp)
    route.add_station(road.stations.last)
  when 2
    print 'Name of station for deleting: '
    st = gets.chomp
    route.delete_station(road.stations.find { |s| s.name == st })
  when 3
    train.route = route
  when 4
    train.class == PassengerTrain ? train.add_one_carriage(PassCarriage.new) : train.add_one_carriage(CargoCarriage.new)
  when 5
    train.remove_one_carriage
  when 6
    train.move_to_next_station if train.route
  when 7
    train.move_to_previous_station if train.route
  end
end

def info(option, road)
  case option
  when 1
    print "Number of route in the list of routes (0, 1, 2, ...): "
    n = gets.to_i
    route = road.routes[n]
    route ? route.display : puts("There is no route ##{n}")
  when 2
    print 'Station: '
    st = gets.chomp
    st = road.stations.find { |s| s.name == st }
    st.trains_on_the_station if st
  when 3
    road.trains
  end
end
