module StationActions
  def create_station
    name = ask('Введите имя станции:')
    stations << Station.new(name)
    puts 'Станция создана'
  rescue StandardError => e
    puts "#{e}. Еще раз"
  end

  def show_stations
    stations.empty? ? (puts 'Станции не созданы') : (puts stations.map(&:name))
  end

  def show_trains
    station = get_by_choice('станции', stations, :name)

    station.train_block do |train|
      puts "Номер: #{train.number}, Тип поезда: #{train.type}, Кол-во вагонов: #{train.wagons.count}"
    end
  end
end
