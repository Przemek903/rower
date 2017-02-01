class AddRackAndHireRackToStations < ActiveRecord::Migration
  def change
    add_column :stations, :rack, :integer
    add_column :stations, :hireRack, :float
  end
end
