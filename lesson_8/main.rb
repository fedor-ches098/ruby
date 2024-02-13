require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'validate'
require_relative 'actions/route_actions'
require_relative 'actions/station_actions'
require_relative 'actions/train_actions'
require_relative 'actions/support_actions'

class Controller
  include RouteActions
  include StationActions
  include TrainActions
  include SupportActions

  attr_accessor :stations, :routes, :trains

  TRAIN_CLASS = { cargo: CargoTrain, passenger: PassengerTrain }.freeze

  def initialize
    @stations = []
    @routes   = []
    @trains   = []
  end

  def start
    loop do
      run
    end
  end

  def run
    menu(MENU)
    number = gets.chomp.to_i
    action_hash = {
      1 => 'create_station', 2 => 'create_train', 3 => 'create_route',
      4 => 'edit_station', 5 => 'add_route', 6 => 'add_wagon',
      7 => 'remove_wagon', 8 => 'go_station', 9 => 'show_stations',
      10 => 'show_trains', 11 => 'show_wagons', 12 => 'load_wagon', 13 => 'exit'
    }
    method(action_hash[number]).call
  end

  private

  MENU = [
    'Создать станцию', 'Создать поезд', 'Создать маршрут', 'Добавить/Удалить станцию',
    'Назначить маршрут поезду', 'Добавить вагон к поезду', 'Отцепить вагон от поезда',
    'Переместить поезд по маршруту', 'Просмотреть список станций',
    'Просмотреть список поездов на станции', 'Просмотреть список вагонов поезда', 'Занять место или объем в вагоне',
    'Выход'
  ].freeze

  def menu(menu)
    menu.each_with_index { |i, n| puts "#{n + 1} #{i}" }
  end
end

Controller.new.start
