class ChangeWeatherDateType < ActiveRecord::Migration
  def change
    change_column :weathers, :weather_date,  :date
  end
end
