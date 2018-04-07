require_relative 'train'
require_relative 'passtrain_cargotrain_carriages'
require_relative 'station'
require_relative 'optional_methods'
require_relative 'rail_road'

rr = RailRoad.new

puts "Welcome to Railway Control System!
You're alowed to work with trains, routes and stations
\n___MENU___
  1 - creating items
  2 - managing
  3 - info about items
  0 - exit\n"

loop do
  print "Enter a MENU option: "
  menu_option = gets.to_i

  case menu_option
  when 1
    puts "\n___CREATING MENU___:
    1 - create a passenger train
    2 - create a cargo train, required attribute - number of train
    3 - create a passenger carriage
    4 - create a cargo carriage
    5 - create a station, required attribute - name of station
    6 - create a route, two required attributes - start and end stations
    0 - exit to the previous menu\n"
    loop do
      print "Enter a CREATING option: "
      option = gets.to_i
      p creating(option, rr)
      break if option.zero?
    end

  when 2
    puts "\n___MANAGING MENU___
    1 - add station to the route
    2 - delete station from the route
    3 - set the route for train
    4 - add one carriage to the train
    5 - remove one carriage from the train
    6 - move the train to the next station
    7 - move the train to the previous station
    0 - exit to the previous menu\n"

    print "Number of train: "
    number = gets.chomp
    train = rr.trains.find { |t| t.number == number }
    unless train
      puts 'There is no such train in the list'
      next
    end
    print "Number of a route in the list of routes (0, 1, 2, ...): "
    n = gets.to_i
    route = rr.routes[n]
    unless route
      puts "There is no route ##{n}"
      next
    end

    loop do
      print "Enter a MANAGING option: "
      option = gets.to_i
      p managing(option, train, route, rr)
      break if option.zero?
    end

  when 3
    puts "\n___INFO MENU___
    1 - display the route
    2 - list of trains on the station
    3 - list of all trains in the rail road
    0 - exit to the previous menu\n"

    loop do
      print "Enter a INFO option: "
      option = gets.to_i
      p info(option, rr)
      break if option.zero?
    end
  end
end


