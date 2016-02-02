class CreateFavoriteStations < ActiveRecord::Migration
  def change
    create_table :favorite_stations do |t|
      t.integer :station_id
      t.integer :user_id

      t.timestamps
    end
  end
end
