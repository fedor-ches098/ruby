module RouteActions
  def create_route
    first_station = get_by_choice('станции', stations, :name)
    last_station = get_by_choice('станции', stations, :name)
    routes << Route.new(first_station, last_station)
    puts 'Маршрут создан'
  rescue StandardError => e
    puts "#{e}. Еще раз"
    retry
  end

  def edit_station
    route = get_by_choice('маршрута', routes, :stations)
    input1 = ask('Введите действие: (add/remove)')

    if input1 == 'add'
      station = get_by_choice('станции', stations, :name)
      route.add_station(station)
    else
      station = get_by_choice('станции', route.stations, :name)
      route.remove_station(station)
    end
  end
end
