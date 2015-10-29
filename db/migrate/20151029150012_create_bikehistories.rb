class CreateBikehistories < ActiveRecord::Migration
  def change
    create_table :bikehistories do |t|
      t.integer :stationId
      t.float :laf
      t.float :lng
      t.string :name
      t.string :bikes
      t.integer :bike_racks
      t.string :bike_numbers
      t.integer :city_id

      t.timestamps
    end
  end
end
