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
CREATING_MENU = "\n___CREATING MENU___
    1 - create a passenger train, required attribute - number of train
    2 - create a cargo train, required attribute - number of train
    3 - create a passenger carriage, required attribute - amount of seats
    4 - create a cargo carriage, required attribute - volume
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
    6 - take seats/volume in the carriage
    0 - exit to the previous menu\n"
INFO_MENU = "\n___INFO MENU___
    1 - show the route
    2 - detailed list of trains on the station
    3 - list of all trains in the rail road
    4 - list of all stations
    5 - details about train
    0 - exit to the previous menu\n"

puts "\nWELCOME to Railway Control System!\n
You're alowed to work with trains, routes and stations"

rr = RailRoad.new
rr.start
