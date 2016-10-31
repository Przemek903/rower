class CreateTwoDirectionTraffics < ActiveRecord::Migration
  def change
    create_table :two_direction_traffics do |t|
      t.integer :fromFirstToSecond
      t.integer :formSecondToFirst
      t.integer :totalCount
      t.integer :stationA_id
      t.integer :stationB

      t.timestamps
    end
  end
end
