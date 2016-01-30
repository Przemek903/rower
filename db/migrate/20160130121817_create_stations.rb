class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :stationNumber
      t.float :lng
      t.float :lat
      t.string :name

      t.timestamps
    end
  end
end
