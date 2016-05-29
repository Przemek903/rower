class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :weathers, :date, :weather_date
  end
end
