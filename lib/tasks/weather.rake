desc "Get Weather data from csv file"
task :weather_data => :environment do
  require 'csv'
  Weather.delete_all
  CSV.foreach("weather.csv") do |row|
    Weather.create(
      max_temp: row[1].to_i,
      min_temp: row[3].to_i,
      avg_temp: row[2].to_i,
      conditions: row[4],
      weather_date: row[0]
    )
  end
  Weather.where(weather_date: nil).delete_all
end