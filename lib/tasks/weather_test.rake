desc "Weather analysis"
task :weather_test => :environment do
  hireNumbers = Weather.all.group(:avg_temp).order('avg_temp asc').sum(:count)
  dayNumbers = Weather.all.group(:avg_temp).order('avg_temp asc').count(:count)
  avg_count = {}
  hireNumbers.each do |k,v|
    avg_count[k] = v/dayNumbers[k]
  end
  p '-------------------------------------------------------------'
  p "srednia temperatura -> srednia liczba wypozyczen w ciagu dnia"
  p avg_count
  p '-------------------------------------------------------------'

  weatherAndCount = Weather.all.group(:conditions).sum(:count)

  countWeather = {}
  weathers = ['deszcz', 'mgła', 'burza', 'śnieg', 'grad']
  weathers.each do |weat|
    days = Weather.where('conditions LIKE ?', '%'+weat+'%').count
    suma = Weather.where('conditions LIKE ?', '%'+weat+'%').sum(:count)
    countWeather[weat] = suma/days
  end
  countWeather['brak'] = Weather.where(conditions: nil).sum(:count)/Weather.where(conditions: nil).count
  p '-------------------------------------------------------------'
  p "Warunki -> srednia liczba wypozyczen w ciagu dnia"
  p countWeather

end