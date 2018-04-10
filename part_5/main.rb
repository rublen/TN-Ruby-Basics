require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'route'
require_relative 'station'
require_relative 'rail_road'

MAIN_MENU = "\n___MAIN MENU___
  1 - creating items
  2 - managing routes
  3 - managing trains
  4 - info about items
  0 - exit\n"
CREATING_MENU = "\n___CREATING MENU___:
    1 - create a passenger train, required attribute - number of train
    2 - create a cargo train, required attribute - number of train
    3 - create a passenger carriage
    4 - create a cargo carriage
    5 - create a station, required attribute - name of station
    6 - create a route, two required attributes - start and end stations
    0 - exit to the previous menu\n"
MANAGING_ROUTES_MENU = "    1 - add station to the route
    2 - delete station from the route
    0 - exit to the previous menu\n"
MANAGING_TRAINS_MENU = "    1 - set the route for train
    2 - add one carriage to the train
    3 - remove one carriage from the train
    4 - move the train to the next station
    5 - move the train to the previous station
    0 - exit to the previous menu\n"
INFO_MENU = "\n___INFO MENU___
    1 - show the route
    2 - list of trains on the station
    3 - list of all trains in the rail road
    0 - exit to the previous menu\n"

rr = RailRoad.new

puts "Welcome to Railway Control System!
You're alowed to work with trains, routes and stations"

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
      p rr.creating(option)
      break if option.zero?
    end

  when 2
    puts "\n___MANAGING ROUTES MENU___"
    route = rr.get_route
    puts MANAGING_ROUTES_MENU
    loop do
      print "\nEnter a MANAGING ROUTES option: "
      option = gets.to_i
      p rr.route_managing(option, route)
      break if option.zero?
    end

  when 3
    puts "\n___MANAGING TRAINS MENU___"
    train = rr.get_train
    puts MANAGING_TRAINS_MENU
    loop do
      print "\nEnter a MANAGING TRAINS option: "
      option = gets.to_i
      p rr.train_managing(option, train)
      break if option.zero?
    end

  when 4
    puts INFO_MENU
    loop do
      print "\nEnter a INFO option: "
      option = gets.to_i
      p rr.info(option)
      break if option.zero?
    end
  else
    exit
  end
end


