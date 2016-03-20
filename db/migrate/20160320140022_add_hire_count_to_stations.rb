class AddHireCountToStations < ActiveRecord::Migration
  def change
    add_column :stations, :hireCount, :integer
  end
end
